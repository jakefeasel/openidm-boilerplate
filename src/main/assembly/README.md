Assembling your custom OpenIDM project
======================================

The zip.xml file in this folder instructs the maven assembly plugin to build your custom OpenIDM project. This will include all of the custom code, configuration, and resources you have specified that define your project along with the core OpenIDM server and whatever other external dependencies you have declared in the root pom.xml. See the comments in-line within zip.xml for tips on changes you may be interested in making specifically for your project.