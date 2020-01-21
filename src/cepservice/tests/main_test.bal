import ballerina/test;
import ballerina/http;

http:Client clientEP = new("http://localhost:9090");

@test:Config {}
function statusCode200ExpectedWhenGivenValidCep() {
    var expected = "200";
    var response = clientEP->get("/cep/94460100");
    if (response is http:Response) {
        var actualStatusCode = response.statusCode.toString();
        test:assertEquals(actualStatusCode, expected, msg = "Request failed.");
    } else {
        test:assertFail(msg = "Request error.");
    }
}

@test:Config {}
function responseContentTypeJsonExpectedWhenGivenValidCep() {
    var expected = "application/json";
    var response = clientEP->get("/cep/00000000");
    if (response is http:Response) {
        var actualContentType = response.getContentType();
        test:assertEquals(actualContentType, expected, msg = "Response content type is not a json.");
    } else {
        test:assertFail(msg = "Request error.");
    }
}

@test:Config {}
function AddressDetailsExpectedWhenGivenValidCep() {
    json expected = JSON_SCHEMA;
    var response = clientEP->get("/cep/94460100");
    if (response is http:Response) {
        var actualPayload = response.getJsonPayload();
        if (actualPayload is json) {
            test:assertEquals(actualPayload, expected, msg = "Response mismatch.");
        } else {
            test:assertFail(msg = "Failed to retrieve payload.");
        }
    } else {
        test:assertFail(msg = "Request error.");
    }
}

@test:Config {}
function emptyArrayExpectedWhenGivenInvalidCep() {
    json expected = [];
    var response = clientEP->get("/cep/00000000");
    if (response is http:Response) {
        var actualPayload = response.getJsonPayload();
        if (actualPayload is json) {
            test:assertEquals(actualPayload, expected, msg = "Response mismatch.");
        } else {
            test:assertFail(msg = "Failed to retrieve payload.");
        }
    } else {
        test:assertFail(msg = "Request error.");
    }
}