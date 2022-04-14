component {

    function init() {
        try {
            this.token = structKeyExists(server.system.environment, "GITHUB_ACCESS") ? server.system.environment['GITHUB_ACCESS'] : "";
        } catch(any e) {

        }
    }


    public string function getEvents() {
        httpService = new http();
        httpService.setUrl("https://api.github.com/events");
        httpService.setMethod("GET");
        httpService.addParam(type="header", name="Accept", value="application/vnd.github.v3+json");

        result = httpService.send().getPrefix().filecontent;
        return result;
    }


    public string function getNetworkEvents(required string owner, required string repo) {
        httpService = new http();
        httpService.setUrl("https://api.github.com/networks/#encodeForHTML(arguments.owner)#/#encodeForHTML(arguments.repo)#/events");
        httpService.setMethod("GET");
        httpService.addParam(type="header", name="Accept", value="application/vnd.github.v3+json");

        result = httpService.send().getPrefix().filecontent;
        return result;
    }


    public string function getOrgEvents(required string organization) {
        httpService = new http();
        httpService.setUrl("https://api.github.com/orgs/#encodeForHTML(arguments.organization)#/events");
        httpService.setMethod("GET");
        httpService.addParam(type="header", name="Accept", value="application/vnd.github.v3+json");

        result = httpService.send().getPrefix().filecontent;
        return result;
    }


    public string function getRepoEvents(required string owner, required string repo) {
        httpService = new http();
        httpService.setUrl("https://api.github.com/repos/#encodeForHTML(arguments.owner)#/#encodeForHTML(arguments.repo)#/events");
        httpService.setMethod("GET");
        httpService.addParam(type="header", name="Accept", value="application/vnd.github.v3+json");

        result = httpService.send().getPrefix().filecontent;
        return result;
    }


    // // only for authenticated users
    // public string function getUserEvents(required string username) {
    //     httpService = new http();
    //     httpService.setUrl("https://api.github.com/users/#encodeForHTML(arguments.username)#/events");
    //     httpService.setMethod("GET");
    //     httpService.addParam(type="header", name="Accept", value="application/vnd.github.v3+json");
    //
    //     result = httpService.send().getPrefix().filecontent;
    //     return result;
    // }


    // // only for authenticated users
    // public string function getOrgMemberEvents(required string org, required string username) {
    //     httpService = new http();
    //     httpService.setUrl("https://api.github.com/users/#encodeForHTML(arguments.username)#/events/orgs/#encodeForHTML(arguments.org)#");
    //     httpService.setMethod("GET");
    //     httpService.addParam(type="header", name="Accept", value="application/vnd.github.v3+json");
    //
    //     result = httpService.send().getPrefix().filecontent;
    //     return result;
    // }


    public string function getUserEvents(required string username) {
        httpService = new http();
        httpService.setUrl("https://api.github.com/users/#encodeForHTML(arguments.username)#/events/public");
        httpService.setMethod("GET");
        httpService.addParam(type="header", name="Accept", value="application/vnd.github.v3+json");

        result = httpService.send().getPrefix().filecontent;
        return result;
    }


    // get events received by auth user


    // get public events received by user


    public string function getFeeds() {
        httpService = new http();
        httpService.setUrl("https://api.github.com/feeds");
        httpService.setMethod("GET");
        httpService.addParam(type="header", name="Accept", value="application/vnd.github.v3+json");
        httpService.addParam(name='Authorization', value='token #this.token#', type='header');

        result = httpService.send().getPrefix().filecontent;
        return result;
    }


    public string function getNotifications() {
        httpService = new http();
        httpService.setUrl("https://api.github.com/notifications");
        httpService.setMethod("GET");
        httpService.addParam(type="header", name="Accept", value="application/vnd.github.v3+json");
        httpService.addParam(name='Authorization', value='token #this.token#', type='header');

        result = httpService.send().getPrefix().filecontent;
        return result;
    }


    public string function markAllAsRead() {
        httpService = new http();
        httpService.setUrl("https://api.github.com/notifications");
        httpService.setMethod("PUT");
        httpService.addParam(type="header", name="Accept", value="application/vnd.github.v3+json");
        httpService.addParam(name='Authorization', value='token #this.token#', type='header');

        result = httpService.send().getPrefix().filecontent;
        return result;
    }


    public string function getThread(required string thread_id) {
        httpService = new http();
        httpService.setUrl("https://api.github.com/notifications/threads/#encodeForHTML(arguments.thread_id)#");
        httpService.setMethod("GET");
        httpService.addParam(type="header", name="Accept", value="application/vnd.github.v3+json");
        httpService.addParam(name='Authorization', value='token #this.token#', type='header');

        result = httpService.send().getPrefix().filecontent;
        return result;
    }


    public string function markThreadAsRead(required string thread_id) {
        httpService = new http();
        httpService.setUrl("https://api.github.com/notifications/threads/#encodeForHTML(arguments.thread_id)#");
        httpService.setMethod("PATCH");
        httpService.addParam(type="header", name="Accept", value="application/vnd.github.v3+json");
        httpService.addParam(name='Authorization', value='token #this.token#', type='header');

        result = httpService.send().getPrefix().filecontent;
        return result;
    }


    public string function getThreadSubscription(required string thread_id) {
        httpService = new http();
        httpService.setUrl("https://api.github.com/notifications/threads/#encodeForHTML(arguments.thread_id)#/subscription");
        httpService.setMethod("GET");
        httpService.addParam(type="header", name="Accept", value="application/vnd.github.v3+json");
        httpService.addParam(name='Authorization', value='token #this.token#', type='header');

        result = httpService.send().getPrefix().filecontent;
        return result;
    }

}
