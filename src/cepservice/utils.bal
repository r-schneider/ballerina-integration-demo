import ballerina/http;
import ballerina/jsonutils;

function mountXmlRequest(string cep) returns xml {
    xml requestBody = xml   `<ns:consultaCEP xmlns:ns="http://cliente.bean.master.sigep.bsb.correios.com.br/">
                                <cep>${cep}</cep>
                            </ns:consultaCEP>`;
    return requestBody;
}

function convertXmlToJson(xml xmlResponse) returns json {
    json jsonResponse = <@untainted> checkpanic jsonutils:fromXML(xmlResponse, {preserveNamespaces: false});
    return jsonResponse;
}

function createRestResponse(json payload) returns http:Response {
    http:Response response = new;
    response.setJsonPayload(payload);
    return response;
}