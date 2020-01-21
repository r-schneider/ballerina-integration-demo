import ballerina/test;

xmlns "http://cliente.bean.master.sigep.bsb.correios.com.br/" as ns;

string cep = "00000000";

xml mockXml = xml `<ns:consultaCEP>
                                <cep>${cep}</cep>
                            </ns:consultaCEP>`;

json mockJson = { "consultaCEP": {
                    "cep": "00000000"
                    }
                };

@test:Config {}
function shouldMountXmlWithGivenParam() {
    var expected = mockXml;
    var actualXml = mountXmlRequest("00000000");
    test:assertEquals(actualXml, expected, msg = "Xml mismatch.");
}

@test:Config {}
function shouldReturnJsonFromGivenXml() {
}

@test:Config {}
function httpResponseShouldHaveJsonAsPayload() {
    var httpResponse = createRestResponse(mockJson);
    var actual = httpResponse.getJsonPayload();
    test:assertEquals(actual, mockJson, msg = "Payload mismatch.");
}