import ballerina/http;
import wso2/soap;
import ballerina/docker;

@docker:Expose{}
listener http:Listener cepserviceEP = new(9090);

soap:Soap11Client soapEndpoint = new(SOAP_ENDPOINT);

@docker:Config{
    dockerHost: "tcp://localhost:2375",
    name:"cepservice",
    tag:"v1.0"
}

@http:ServiceConfig {
    basePath: "/"
}
service cepService on cepserviceEP {
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