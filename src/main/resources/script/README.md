Custom OpenIDM Scripts
======================

This is the folder that you should use to track all of your custom javascript and groovy files, which you can use for all of your project-specific extensions. Examples include scripts for custom endpoints, correlation, mapping transformations, etc...

The one file that is here by default is access.js. This is the file that is used by the default project to control authorization. Any custom authorization rules that you need to define will involve editing this file. For example, if you need to make a new custom endpoint available anonymously, then you would need to update this file to include it, like so:

        {  
           "pattern"    : "endpoint/myCustomEndpoint",
           "roles"      : "openidm-reg,openidm-authorized",
           "methods"    : "read,action",
           "actions"    : "myAction"
        },

