include "api-gateway/ports/GatedFormatConverter.iol"
include "console.iol"

init
{
  with( GatedFormatConverter.protocol.ssl ) {
    .trustStore = "api-gateway/cacerts.jks"
    .trustStorePassword = "helloworld"
  }
}

// We get the API key from the command line

// Valid: jolie client.ol d04bec1f-60fa-4521-8792-cf844f03e0bb
// Not valid: jolie client.ol 1234-5678
main
{
  xmlToJson@GatedFormatConverter( "<doc><p>Hello</p></doc>" {
      .apiKey = args[0]
  } )( jsonData )
  println@Console( jsonData )()
  // {"doc":{"p":"Hello"}}

  jsonToXml@GatedFormatConverter( jsonData {
    .apiKey = args[0]
  } )( xmlDoc )
  println@Console( xmlDoc )()
  // <?xml version="1.0" encoding="UTF-8" standalone="no"?>
  // <doc><p>Hello</p></doc>
}
