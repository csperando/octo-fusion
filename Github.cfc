component setter="false" getter="false" {


    public function init(required string org, string webhookSecret) {
        try {
            this.token = server.system.environment['GITHUB_ACCESS'];
            this.org = arguments.org;
            this.secret = (StructKeyExists(arguments, "webhookSecret")) ? arguments.webhookSecret : server.system.environment['GITHUB_WEBHOOK_SECRET'];
            this.info = deserializeJSON(getOrgInfo(this.org));
        } catch(any e) {
            this.token = "error";
            this.secret = "error";
            this.org = "error"
            this.info = {"error": e};
        }

        return this;
    }



    function getMembers() {
        cfhttp(url="https://api.github.com/orgs/#this.org#/members" method="GET" result="membersRequest") {
            cfhttpparam(type="header" name="accept" value="application/vnd.github.v3+json");
            cfhttpparam(type="header" name="Authorization" value="token #this.token#");
        }
        return membersRequest.filecontent;


    }



    function getContributionData() {
        repos = deserializeJSON(getRepos());
        members = deserializeJSON(getMembers());

        contributionData = {};
        for(member in members) {
            contributionData[member.login] = {total=0, repos={}, avatar=member.avatar_url, page=member.html_url};
        }

        for(repo in repos) {
            repoName = repo.name;
            cfhttp(url="https://api.github.com/repos/#this.org#/#repoName#/contributors" method="GET" result="contributorsRequest") {
                cfhttpparam(type="header" name="accept" value="application/vnd.github.v3+json");
                cfhttpparam(type="header" name="Authorization" value="token #this.token#");
            }
            contributions = deserializeJSON(contributorsRequest.filecontent);

            for(data in contributions) {
                if(structKeyExists(contributionData, data.login)) {
                    contributionData[data.login].total += data.contributions;
                    contributionData[data.login].repos[repoName] = data.contributions;
                }
            }
        }

        return contributionData;
    }



    boolean function validRequest(required struct requestData) {
        payload = requestData.content.Trim();
        headers = requestData.headers;
        signature = structKeyExists(headers, "X-Hub-Signature-256") ? headers["X-Hub-Signature-256"] : "error";
        return verifySignature( signature, payload, secret );
    }



    boolean function verifySignature( required string signature, required string payload, required string secret ){
        var expectedSignature = "sha256=" & HMAC( arguments.payload, arguments.secret, "HmacSHA256", "utf-8" ).LCase()
        return ( arguments.signature == expectedSignature )
    }



    function refreshAll() {
        webhookUrl = getEndpoint();
        updateHooksUrl(webhookUrl);
    }



    function refreshTunnel() {
        webhookUrl = getEndpoint();
    }



    function refreshWebhooks() {
        updateHooksUrl(webhookUrl);
    }



    function updateHooksUrl(webhookUrl) {
        hooks = deserializeJSON(getCurrentHooks());
        for(h in hooks) {
            if(h.config.url != webhookUrl) {
                patchStatus = patchWebhook(h.id, webhookUrl);
            }
        }
    }



    function getRepos() {
        cfhttp(url="https://api.github.com/orgs/#encodeForHTML(this.org)#/repos", method="GET", result="repoRequest") {
            cfhttpparam(name='Accept', value='application/vnd.github.v3+json', type='header');
            cfhttpparam(name='Authorization', value='token #this.token#', type='header');
        }
        return repoRequest.filecontent;
    }



    function getOrgInfo(organization) {
        cfhttp(url="https://api.github.com/orgs/#encodeForHTML(this.org)#", method="GET", result="hookOutput") { //"
            cfhttpparam(name='Accept', value='application/vnd.github.v3+json', type='header');
            cfhttpparam(name='Authorization', value='token #this.token#', type='header');
        }
        return hookOutput.filecontent;
    }



    function pingWebhook(hookId) {
        cfhttp(url="https://api.github.com/orgs/#encodeForHTML(this.org)#/hooks/#hookId#/pings", method="GET", result="pingRequest") {
            cfhttpparam(name='Accept', value='application/vnd.github.v3+json', type='header');
            cfhttpparam(name='Authorization', value='token #this.token#', type='header');
        }
        return pingRequest.filecontent;
    }



    function patchWebhook(hookId, newUrl) {
        cfhttp(url="https://api.github.com/orgs/#encodeForHTML(this.org)#/hooks/#hookId#", method="PATCH", result="hookPatchRequest") {
            cfhttpparam(name='Accept', value='application/vnd.github.v3+json', type='header');
            cfhttpparam(name='Authorization', value='token #this.token#', type='header');
            cfhttpparam(name='d', value='{"config":{"url":"#newUrl#","secret":"#this.secret#"}}', type='body');
        }
        return hookPatchRequest.filecontent;
    }



    function createWebhook(webhookUrl) {
        cfhttp(url="https://api.github.com/orgs/#encodeForHTML(this.org)#/hooks", method="POST", result="hookPostRequest") {
            cfhttpparam(name='Accept', value='application/vnd.github.v3+json', type='header');
            cfhttpparam(name='Authorization', value='token #this.token#', type='header');
            cfhttpparam(name='d', value='{"name":"web","config":{"url":"#webhookUrl#","secret":"#this.secret#"}}', type='body');
        }
        return hookPostRequest;
    }



    function deleteWebhook(hookId) {
        cfhttp(url="https://api.github.com/orgs/#encodeForHTML(this.org)#/hooks/#hookId#", method="DELETE", result="hookDeleteRequest") {
            cfhttpparam(name='Accept', value='application/vnd.github.v3+json', type='header');
            cfhttpparam(name='Authorization', value='token #this.token#', type='header');
        }
        return hookDeleteRequest.filecontent;
    }



    function getCurrentHooks() {
        cfhttp(url="https://api.github.com/orgs/#encodeForHTML(this.org)#/hooks", method="GET", result="hookOutput") {
            cfhttpparam(name='Accept', value='application/vnd.github.v3+json', type='header');
            cfhttpparam(name='Authorization', value='token #this.token#', type='header');
        }
        return hookOutput.filecontent;
    }



    function getEndpoint() {
        // ngork used for tunnel - https://ngrok.com/docs
        // free plan generates a random url, so needs to be updated occasionally
        ngrokOutputPath = "/assets/ngrok.txt";
        if(!tunnelExists(ngrokOutputPath)) {
            // May take some time on startup, sleep and retry
            errorCount = 0;
            while(errorCount < 6) {
                errorCount += 1;
                createTunnel(ngrokOutputPath, errorCount);
                if(tunnelExists(ngrokOutputPath)) {
                    break;
                } else {
                    sleep(5000);
                }
            }
        }
        return getTunnelUrl(ngrokOutputPath) & "/index.cfm/webhooks/github";
    }



    function getTunnelUrl(ngrokOutputPath) {
        // api docs - https://ngrok.com/docs#list-tunnels
        file = fileRead(expandPath(ngrokOutputPath));
        JSONStart = find('{"tunnels":', file);
        tunnelJSON = mid(file, JSONStart, len(file)-JSONstart);
        tunnel = deserializeJSON(tunnelJSON);
        tunnelUrl = tunnel.tunnels[1].public_url;
        return tunnelUrl;
    }



    // this requires an external script to run
    // also requires NGROK_AUTH environment variable to be defined
    function createTunnel(ngrokOutputPath, count) {
        thread action="run" name="ngrok-#count#" {
            try {
                cfexecute(name="C:\lucee\tomcat\webapps\ROOT\tunnel.cmd",
                    arguments="-x",
                    variable="stdOut",
                    outputFile=ngrokOutputPath,
                    errorFile="/assets/ngrokError.txt",
                    timeout="3",
                    terminateOnTimeout="true");
            } catch(any e) {
                // debug
            }
        }
        thread action="terminate" name="ngrok-#count#";
    }



    function tunnelExists(ngrokOutputPath) {
        try {
            tunnelUrl = getTunnelUrl(ngrokOutputPath);
            cfhttp(url=tunnelUrl, method="HEAD", result="tunnelStatus");
            return tunnel.status_code == 200;

        } catch(any e) {
            return false;
        }
    }



} // end component
