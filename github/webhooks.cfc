component {

    public function init(required string org, required string token) {
        this.org = arguments.org;
        this.token = arguments.token;
        this.auth = new components.github.auth();
        return this;
    }


    public string function getWebhooks() {
        cfhttp(url="https://api.github.com/orgs/#encodeForHTML(this.org)#/hooks", method="GET", result="hookOutput") {
            cfhttpparam(name='Accept', value='application/vnd.github.v3+json', type='header');
            cfhttpparam(name='Authorization', value='token #this.token#', type='header');
        }
        return hookOutput.filecontent;
    }


    public string function pingWebhook(required string hookId) {
        cfhttp(url="https://api.github.com/orgs/#encodeForHTML(this.org)#/hooks/#hookId#/pings", method="GET", result="pingRequest") {
            cfhttpparam(name='Accept', value='application/vnd.github.v3+json', type='header');
            cfhttpparam(name='Authorization', value='token #this.token#', type='header');
        }
        return pingRequest.filecontent;
    }


    public string function pingWebhook(required string hookId) {
        cfhttp(url="https://api.github.com/orgs/#encodeForHTML(this.org)#/hooks/#hookId#/pings", method="GET", result="pingRequest") {
            cfhttpparam(name='Accept', value='application/vnd.github.v3+json', type='header');
            cfhttpparam(name='Authorization', value='token #this.token#', type='header');
        }
        return pingRequest.filecontent;
    }


    // update arg to take config JSON and parse within cfhttp
    function patchWebhook(hookId, newUrl) {
        cfhttp(url="https://api.github.com/orgs/#encodeForHTML(this.org)#/hooks/#hookId#", method="PATCH", result="hookPatchRequest") {
            cfhttpparam(name='Accept', value='application/vnd.github.v3+json', type='header');
            cfhttpparam(name='Authorization', value='token #this.token#', type='header');
            cfhttpparam(name='d', value='{"config":{"url":"#newUrl#","secret":"#this.secret#"}}', type='body');
        }
        return hookPatchRequest.filecontent;
    }


    // update arg to take config JSON and parse within cfhttp
    function createWebhook(webhookUrl) {
        cfhttp(url="https://api.github.com/orgs/#encodeForHTML(this.org)#/hooks", method="POST", result="hookPostRequest") {
            cfhttpparam(name='Accept', value='application/vnd.github.v3+json', type='header');
            cfhttpparam(name='Authorization', value='token #this.token#', type='header');
            cfhttpparam(name='d', value='{"name":"web","config":{"url":"#webhookUrl#","secret":"#this.secret#"}}', type='body');
        }
        return hookPostRequest;
    }


    public string function deleteWebhook(required string hookId) {
        cfhttp(url="https://api.github.com/orgs/#encodeForHTML(this.org)#/hooks/#hookId#", method="DELETE", result="hookDeleteRequest") {
            cfhttpparam(name='Accept', value='application/vnd.github.v3+json', type='header');
            cfhttpparam(name='Authorization', value='token #this.token#', type='header');
        }
        return hookDeleteRequest.filecontent;
    }

}
