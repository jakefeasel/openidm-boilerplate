OpenIDM Config
==============

In this folder, you will need to save the versions of the OpenIDM service configuration files (.json files primarily, but also .properties or .xml as needed). These will be modified versions of the files that OpenIDM normally operates on. Examples that you'll likely need to be adding in here include:

* provisioner.openicf-ldap.json (where ldap is one of your remote connected resources)
* sync.json (the mappings defining how your resources relate to each other)
* audit.json (specific auditing rules)
* repo.jdcb.json (Your repository, including JDBC server connection, queries, and table structures)
* endpoint-custom.json (Any custom endpoint scripts you develop)

And anything else you need to customize as part of your project configuration.

Note that the copyright of the default configuration files from OpenIDM is owned by ForgeRock, Inc. The license they are distributed under is CDDL, just like the rest of the OpenIDM source.