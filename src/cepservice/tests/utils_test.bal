import ballerina/test;

@test:Config {}
function shouldMountXmlWithGivenParam() {
    var expectedXml = XML_REQUEST;
    var actualXml = mountXmlRequest("00000000");
    test:assertEquals(actualXml, expectedXml, msg = "Xml mismatch.");
}

@test:Config {}
function shouldConvertXmlToJson() {
    var expectedJson = JSON_RESPONSE;
    var actualJson = convertXmlToJson(XML_RESPONSE);
    test:assertEquals(actualJson, expectedJson, msg = "Json conversion failed.");
}

@test:Config {}
function httpResponseShouldHaveJsonAsPayload() {
    var httpResponse = createRestResponse(JSON_RESPONSE);
    var expectedPayload = JSON_RESPONSE;
    var actualPayload = httpResponse.getJsonPayload();
    test:assertEquals(actualPayload, expectedPayload, msg = "Payload mismatch.");
}