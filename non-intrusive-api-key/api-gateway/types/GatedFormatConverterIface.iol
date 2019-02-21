// We get new types from the extender used in the API gateway.
// These can be generated automatically by jolie2surface.

type GatedJsonToXmlRequest:string {
	.apiKey:string
}

type GatedJsonToXmlRequest:string {
	.apiKey:string
}

interface GatedFormatConverterIface {
RequestResponse:
	jsonToXml(GatedJsonToXmlRequest)(string) throws InvalidApiKey(string),
	xmlToJson(GatedJsonToXmlRequest)(string) throws InvalidApiKey(string)
}
