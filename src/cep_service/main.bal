import ballerina/http;
import wso2/soap;


soap:Soap11Client soapEndpoint = new(SOAP_ENDPOINT);

@http:ServiceConfig {
    basePath: "/"
}
service cepService on new http:Listener(9090) {
    @http:ResourceConfig {
        methods: ["GET"],
        path: "cep/{cep}"
    }
    resource function getAddress(http:Caller caller, http:Request request, string cep) {
        var soapResponse = checkpanic soapEndpoint->sendReceive(<@untainted> mountXmlRequest(cep), "");
        var xmlResponse = checkpanic soapResponse.httpResponse.getXmlPayload();
        var response = createRestResponse(convertXmlToJson(xmlResponse));
        error? respond = caller->respond(<@untained>  response);
    }
}