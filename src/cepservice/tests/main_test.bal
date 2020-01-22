import ballerina/test;
import ballerina/http;

http:Client clientEP = new("http://localhost:9090");
              
@test:Config {}
function statusCode200ExpectedWhenGivenValidCep() {
    var expectedStatusCode = "200";
    var response = clientEP->get("/cep/94460100");
    if (response is http:Response) {
        var actualStatusCode = response.statusCode.toString();
        test:assertEquals(actualStatusCode, expectedStatusCode, msg = "Request failed.");
    } else {
        test:assertFail(msg = "Request error.");
    }
}

@test:Config {}
function responseContentTypeJsonExpectedWhenGivenValidCep() {
    var expectedContentType = "application/json";
    var response = clientEP->get("/cep/00000000");
    if (response is http:Response) {
        var actualContentType = response.getContentType();
        test:assertEquals(actualContentType, expectedContentType, msg = "Response content type is not a json.");
    } else {
        test:assertFail(msg = "Request error.");
    }
}

@test:Config {}
function AddressDetailsExpectedWhenGivenValidCep() {
    json expectedPayload = JSON_RESPONSE;
    var response = clientEP->get("/cep/94460100");
    if (response is http:Response) {
        var actualPayload = response.getJsonPayload();
        if (actualPayload is json) {
            test:assertEquals(actualPayload, expectedPayload, msg = "Response mismatch.");
        } else {
            test:assertFail(msg = "Failed to retrieve payload.");
        }
    } else {
        test:assertFail(msg = "Request error.");
    }
}

@test:Config {}
function invalidCepResponseExpectedWhenGivenInvalidCep() {
    json expectedPayload = INVALID_CEP_MSG;
    var response = clientEP->get("/cep/00000000");
    if (response is http:Response) {
        var actualPayload = response.getJsonPayload();
        if (actualPayload is json) {
            test:assertEquals(actualPayload, expectedPayload, msg = "Response mismatch.");
        } else {
            test:assertFail(msg = "Failed to retrieve payload.");
        }
    } else {
        test:assertFail(msg = "Request error.");
    }
}