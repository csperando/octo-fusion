component {

    public function init() {

    }


    private boolean function validRequest(required struct requestData) {
        payload = requestData.content.Trim();
        headers = requestData.headers;
        signature = structKeyExists(headers, "X-Hub-Signature-256") ? headers["X-Hub-Signature-256"] : "error";
        return verifySignature( signature, payload, secret );
    }


    private boolean function verifySignature( required string signature, required string payload, required string secret ){
        var expectedSignature = "sha256=" & HMAC( arguments.payload, arguments.secret, "HmacSHA256", "utf-8" ).LCase();
        return ( arguments.signature == expectedSignature );
    }
    
}
