include "types/FormatConverterIface.iol"
include "json_utils.iol"
include "xml_utils.iol"

execution { concurrent }

inputPort FormatConverterInput {
Location: "socket://localhost:8080"
Protocol: sodep
Interfaces: FormatConverterIface
}

main
{
	[ xmlToJson( request )( response ) {
		request.options.includeRoot = true;
		xmlToValue@XmlUtils( request )( xml );
		getJsonString@JsonUtils( xml )( response )
	} ]

	[ jsonToXml( request )( response ) {
		getJsonValue@JsonUtils( request )( xmlRequest.root );
		xmlRequest.isXmlStore = false;
		valueToXml@XmlUtils( xmlRequest )( response )
	} ]
}
