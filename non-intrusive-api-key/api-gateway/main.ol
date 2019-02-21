include "../format-converter/ports/FormatConverter.iol"
include "file.iol"

type ApiKeyExtension:void { .apiKey:string }

interface extender ApiKeyExtender {
RequestResponse:
// Extend all operations to require an api key
  *(ApiKeyExtension)(void) throws InvalidApiKey(string)
}

inputPort Gateway {
Location: "socket://localhost:8081"
Protocol: sodeps {
	.ssl.keyStore = "keystore.jks";
	.ssl.keyStorePassword = "helloworld"
}
Aggregates: FormatConverter with ApiKeyExtender
}

// We use a simple file-based storage for API keys.
// This is where you wanna use a database instead.
init
{
	// Load the API keys
	readFile@File( {
		.filename = "apikeys.json",
		.format = "json"
	} )( store );

	// Put the API keys in a map, for later fast retrieval
	for( key in store.apiKeys ) {
		global.apiKeys.(key) = true
	}
}

courier Gateway {
  // Intercept all traffic to the format converter's API
  [ interface FormatConverterIface( request )( response ) ] {
    if ( !is_defined(global.apiKeys.(request.apiKey)) ) {
  		throw(
  			InvalidApiKey,
  			"The provided API key is invalid: " + request.apiKey
  		)
  	};

    // forward automatically gets rid of the apiKey field,
    // a transformation that Jolie infers from the type extender.
    forward( request )( response )
  }
}

embedded {
Jolie: "../format-converter/main.ol"
}

main
{
  linkIn( Shutdown )
}
