include "format_converter/ports/FormatConverter.iol"
include "console.iol"

main
{
  xmlToJson@FormatConverter( "<doc><p>Hello</p></doc>" )( jsonData );
  println@Console( jsonData )();
  // {"doc":{"p":"Hello"}}

  jsonToXml@FormatConverter( jsonData )( xmlDoc );
  println@Console( xmlDoc )()
  // <?xml version="1.0" encoding="UTF-8" standalone="no"?>
  // <doc><p>Hello</p></doc>
}
