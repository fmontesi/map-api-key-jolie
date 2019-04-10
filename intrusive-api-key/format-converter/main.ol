include "types/FormatConverterIface.iol"
include "json_utils.iol"
include "xml_utils.iol"
include "file.iol"

execution { concurrent }

inputPort FormatConverterInput {
Location: "socket://localhost:8080"
Protocol: sodeps {
	.ssl.keyStore = "keystore.jks"
	.ssl.keyStorePassword = "helloworld"
}
Interfaces: FormatConverterIface
}

// We use a simple file-based storage for API keys.
// This is where you wanna use a database instead.
init
{
	// Load the API keys
	readFile@File( {
		.filename = "apikeys.json",
		.format = "json"
	} )( store )

	// Put the API keys in a map, for later fast retrieval
	for( key in store.apiKeys ) {
		global.apiKeys.(key) = true
	}
}

define checkApiKey
{
	// If the key is not valid, throw a fault
	if ( !is_defined(global.apiKeys.(request.apiKey)) ) {
		throw(
			InvalidApiKey,
			"The provided API key is invalid: " + request.apiKey
		)
	} else {
		undef( request.apiKey )
	}
}

main
{
	[ xmlToJson( request )( response ) {
		checkApiKey
		request.options.includeRoot = true
		xmlToValue@XmlUtils( request )( xml )
		getJsonString@JsonUtils( xml )( response )
	} ]

	[ jsonToXml( request )( response ) {
		checkApiKey
		getJsonValue@JsonUtils( request )( xmlRequest.root )
		xmlRequest.isXmlStore = false
		valueToXml@XmlUtils( xmlRequest )( response )
	} ]
}
