component {

    public function init(string token) {
        this.token = arguments.token;
    }


    public string function getRepo(required string owner, required string repo) {
        cfhttp(url="https://api.github.com/repos/#encodeForHTML(arguments.owner)#/#encodeForHTML(arguments.repo)#", method="GET", result="repoRequest") {
            cfhttpparam(name='Accept', value='application/vnd.github.v3+json', type='header');
        }
        return repoRequest.filecontent;
    }


    public string function updateRepo(
        required string owner,
        required string repo,
        string name,
        string description,
        string homepage,
        boolean private,
        string visibility,
        // struct security_and_analysis,
        boolean has_issues,
        boolean has_projects,
        boolean has_wiki,
        boolean is_template,
        string default_branch,
        boolean allow_squash_merge,
        boolean allow_merge_commit,
        boolean allow_rebase_merge,
        boolean allow_auto_merge,
        boolean delete_branch_on_merge,
        boolean archived,
        boolean allow_forking
    ) {
        body = {};
        for(var arg in arguments) {
            if(arguments["#arg#"] != "" and arg != "owner" and arg != "repo") {
                body["#arg#"] = arguments["#arg#"];
            }
        }
        body = serialize(body);

        cfhttp(url="https://api.github.com/repos/#encodeForHTML(arguments.owner)#/#encodeForHTML(arguments.repo)#", method="PATCH", result="repoRequest") {
            cfhttpparam(name='Accept', value='application/vnd.github.v3+json', type='header');
            cfhttpparam(name='d', type='body', value='#body#');
            cfhttpparam(name='Authorization', value='token #this.token#', type='header');
        }
        return repoRequest.filecontent;
    }

}
