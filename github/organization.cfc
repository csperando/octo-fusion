component {

    public function init(required string organizationName, required string token) {
        this.org = arguments.organizationName;
        this.token = arguments.token;
        this.auth = new components.github.auth();
        return this;
    }


    public string function getMembers() {
        cfhttp(url="https://api.github.com/orgs/#this.org#/members" method="GET" result="membersRequest") {
            cfhttpparam(type="header" name="accept" value="application/vnd.github.v3+json");
            cfhttpparam(type="header" name="Authorization" value="token #this.token#");
        }
        return membersRequest.filecontent;
    }


    public string function getRepos() {
        cfhttp(url="https://api.github.com/orgs/#encodeForHTML(this.org)#/repos", method="GET", result="repoRequest") {
            cfhttpparam(name='Accept', value='application/vnd.github.v3+json', type='header');
            cfhttpparam(name='Authorization', value='token #this.token#', type='header');
        }
        return repoRequest.filecontent;
    }


    public string function getOrgInfo() {
        cfhttp(url="https://api.github.com/orgs/#encodeForHTML(this.org)#", method="GET", result="infoRequest") { //"
            cfhttpparam(name='Accept', value='application/vnd.github.v3+json', type='header');
            cfhttpparam(name='Authorization', value='token #this.token#', type='header');
        }
        return infoRequest.filecontent;
    }


}
