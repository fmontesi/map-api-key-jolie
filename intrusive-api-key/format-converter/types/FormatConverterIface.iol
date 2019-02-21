// In the intrusive API key method, we have to change
// all input types and declare the new fault for all operations.

type JsonToXmlRequest:string {
	.apiKey:string
}

type XmlToJsonRequest:string {
	.apiKey:string
}

interface FormatConverterIface {
RequestResponse:
	jsonToXml(JsonToXmlRequest)(string) throws InvalidApiKey(string),
	xmlToJson(XmlToJsonRequest)(string) throws InvalidApiKey(string)
}
