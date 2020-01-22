import ballerina/test;

xmlns "http://cliente.bean.master.sigep.bsb.correios.com.br/" as ns;

string cep = "00000000";

xml mockXml = xml `<ns:consultaCEP>
                                <cep>${cep}</cep>
                            </ns:consultaCEP>`;                                          

@test:Config {}
function shouldMountXmlWithGivenParam() {
    var expected = mockXml;
    var actualXml = mountXmlRequest("00000000");
    test:assertEquals(actualXml, expected, msg = "Xml mismatch.");
}

@test:Config {}
function shouldReturnJsonFromGivenXml() {
    var expected = JSON_RESPONSE;
    var actual = convertXmlToJson(XML_RESPONSE);
    test:assertEquals(actual, expected, msg = "Json conversion failed.");
}

@test:Config {}
function httpResponseShouldHaveJsonAsPayload() {
    var httpResponse = createRestResponse(JSON_RESPONSE);
    var actual = httpResponse.getJsonPayload();
    test:assertEquals(actual, JSON_RESPONSE, msg = "Payload mismatch.");
}