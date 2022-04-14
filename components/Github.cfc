component setter="false" getter="false" {


    public function init(
        boolean action = false,
        boolean activity = false,
        boolean apps = false,
        boolean billing = false,
        boolean branches = false,
        boolean checks = false,
        boolean conduct = false,
        boolean codeScanning = false,
        boolean codespaces = false,
        boolean collaborators = false,
        boolean commits = false,
        boolean dependabot = false,
        boolean dependency = false,
        boolean deployKeys = false,
        boolean deployments = false,
        boolean emojis = false,
        boolean enterprise = false,
        boolean gists = false,
        boolean database = false,
        boolean gitignore = false,
        boolean interactions = false,
        boolean issues = false,
        boolean licences = false,
        boolean markdown = false,
        boolean meta = false,
        boolean metrics = false,
        boolean migrations = false,
        boolean organization = false,
        boolean packages = false,
        boolean pages = false,
        boolean projects = false,
        boolean pulls = false,
        boolean rateLimit = false,
        boolean reactions = false,
        boolean releases = false,
        boolean repositories = false,
        boolean SCIM = false,
        boolean search = false,
        boolean secretScanning = false,
        boolean teams = false,
        boolean users = false,
        boolean webhooks = false,

        string organizationName
    ) {
        try {
            this.token = structKeyExists(server.system.environment, "GITHUB_ACCESS") ? server.system.environment['GITHUB_ACCESS'] : "";
        } catch(any e) {

        }

        this.action = arguments.action ? new components.github.action() : {};
        this.activity = arguments.activity ? new components.github.activity() : {};
        this.apps = arguments.apps ? new components.github.apps() : {};
        this.billing = arguments.billing ? new components.github.billing() : {};
        this.branches = arguments.branches ? new components.github.branches() : {};
        this.checks = arguments.checks ? new components.github.checks() : {};
        this.conduct = arguments.conduct ? new components.github.conduct() : {};
        this.codeScanning = arguments.codeScanning ? new components.github.codeScanning() : {};
        this.codespaces = arguments.codespaces ? new components.github.codespaces() : {};
        this.collaborators = arguments.collaborators ? new components.github.collaborators() : {};
        this.commits = arguments.commits ? new components.github.commits() : {};
        this.dependabot = arguments.dependabot ? new components.github.dependabot() : {};
        this.dependency = arguments.dependency ? new components.github.dependency() : {};
        this.deployKeys = arguments.deployKeys ? new components.github.deployKeys() : {};
        this.deployments = arguments.deployments ? new components.github.deployments() : {};
        this.emojis = arguments.emojis ? new components.github.emojis() : {};
        this.enterprise = arguments.enterprise ? new components.github.enterprise() : {};
        this.gists = arguments.gists ? new components.github.gists() : {};
        this.database = arguments.database ? new components.github.database() : {};
        this.gitignore = arguments.gitignore ? new components.github.gitignore() : {};
        this.interactions = arguments.interactions ? new components.github.interactions() : {};
        this.issues = arguments.issues ? new components.github.issues() : {};
        this.licences = arguments.licences ? new components.github.licences() : {};
        this.markdown = arguments.markdown ? new components.github.markdown() : {};
        this.meta = arguments.meta ? new components.github.meta() : {};
        this.metrics = arguments.metrics ? new components.github.metrics() : {};
        this.migrations = arguments.migrations ? new components.github.migrations() : {};
        this.organization = arguments.organization ? new components.github.organization() : {};
        this.packages = arguments.packages ? new components.github.packages() : {};
        this.pages = arguments.pages ? new components.github.pages() : {};
        this.projects = arguments.projects ? new components.github.projects() : {};
        this.pulls = arguments.pulls ? new components.github.pulls() : {};
        this.rateLimit = arguments.rateLimit ? new components.github.rateLimit() : {};
        this.reactions = arguments.reactions ? new components.github.reactions() : {};
        this.releases = arguments.releases ? new components.github.releases() : {};
        this.repositories = arguments.repositories ? new components.github.repositories() : {};
        this.SCIM = arguments.SCIM ? new components.github.SCIM() : {};
        this.search = arguments.search ? new components.github.search() : {};
        this.secretScanning = arguments.secretScanning ? new components.github.secretScanning() : {};
        this.teams = arguments.teams ? new components.github.teams() : {};
        this.users = arguments.users ? new components.github.users() : {};
        this.webhooks = arguments.webhooks ? new components.github.webhooks(org=arguments.organizationName) : {};

        return this;
    }


}
