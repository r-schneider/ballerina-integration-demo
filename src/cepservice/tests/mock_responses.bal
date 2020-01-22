final xml XML_RESPONSE = xml `<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                                <soap:Body>
                                    <ns2:consultaCEPResponse xmlns:ns2="http://cliente.bean.master.sigep.bsb.correios.com.br/">
                                        <return>
                                            <bairro>São Tomé</bairro>
                                            <cep>94460100</cep>
                                            <cidade>Viamão</cidade>
                                            <complemento2></complemento2>
                                            <end>Rua São Tomé</end>
                                            <uf>RS</uf>
                                        </return>
                                    </ns2:consultaCEPResponse>
                                </soap:Body>
                            </soap:Envelope>`;

final json JSON_RESPONSE =  {  "Body": {
                                    "consultaCEPResponse": {
                                        "return": {
                                            "bairro": "São Tomé",
                                            "cep": "94460100",
                                            "cidade": "Viamão",
                                            "complemento2": "",
                                            "end": "Rua São Tomé",
                                            "uf": "RS"
                                        }
                                    }
                                }                                  
                            };

final json INVALID_CEP_MSG = { "Body": {
                                    "Fault": {
                                        "faultcode": "soap:Server",
                                        "faultstring": "CEP INVÁLIDO",
                                        "detail": {
                                            "SigepClienteException": "CEP INVÁLIDO"
                                        }
                                    }
                                }
                            };