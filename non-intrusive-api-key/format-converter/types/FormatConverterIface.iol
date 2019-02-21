type JsonToXmlRequest:string

type XmlToJsonRequest:string

interface FormatConverterIface {
RequestResponse:
	jsonToXml(JsonToXmlRequest)(string),
	xmlToJson(XmlToJsonRequest)(string)
}
