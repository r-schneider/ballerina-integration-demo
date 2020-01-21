import ballerina/test;
import ballerina/http;

http:Client clientEP = new("http://localhost:9090");

@test:Config {}
function statusCode200ExpectedWhenGivenValidCep() {
    var response = clientEP->get("/cep/94460100");
    if (response is http:Response) {
        test:assertEquals(response.statusCode.toString(), "200", msg = "Request failed.");
    } else {
        test:assertFail(msg = "Request error.");
    }
}

@test:Config {}
function responseContentTypeJsonExpectedWhenGivenValidCep() {
    var response = clientEP->get("/cep/00000000");
    if (response is http:Response) {
        var responseContentType = response.getContentType();
        test:assertEquals(responseContentType, "application/json", msg = "Response content type is not a json.");
    } else {
        test:assertFail(msg = "Request error.");
    }
}

@test:Config {}
function AddressDetailsExpectedWhenGivenValidCep() {
    json expected = JSON_SCHEMA;
    var response = clientEP->get("/cep/94460100");
    if (response is http:Response) {
        var responsePayload = response.getJsonPayload();
        if (responsePayload is json) {
            test:assertEquals(responsePayload, expected, msg = "Response mismatch.");
        } else {
            test:assertFail(msg = "Failed to retrieve payload.");
        }
    } else {
        test:assertFail(msg = "Request error.");
    }
}