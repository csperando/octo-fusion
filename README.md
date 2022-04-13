# Work in progress

A component/library for working with the Github API using ColdFusion. 

```coldFusion
<cfscript>
    git = new components.github(organization=true, organizationName="Wanka Chocolates LLC");
    orgRepos = git.organization.getRepos();
</cfscript>
```

# Reference

[GitHub Api Docs](https://docs.github.com/en/rest/reference)

