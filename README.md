OpenIDM Custom Project Boilerplate
==================================

##Goals - What is this all about?

[ForgeRock OpenIDM](http://openidm.forgerock.org/) is a powerful and flexible platform for building a provisioning solution. As a platform, it is expected that customizations are going to be needed for any particular project implementation. These customizations come in a number of forms, including (but not limited to):

* detailed project configuration
* custom scripts for extensible behavior (either Groovy or JavaScript)
* custom Activiti workflows (implemented with XML)
* project-specific dependencies such as database drivers or libraries for connectors
* user interface changes

Making these customizations is the job of an OpenIDM "Integrator". Normally, Integrators learn about making these changes by reading the [OpenIDM Integrator's Guide](http://openidm.forgerock.org/doc/integrators-guide/index.html). This project boilerplate aims to assist the Integrator by providing a reusable structure to manage the full lifecycle of development for these customizations. With this project boilerplate, the Integrator can treat these project customizations like any other source code - tracked in a working copy, able to be shared with their fellow Integrators, tested by a QA department (or a customer), and eventually deployed to production. With this boilerplate it is expected that Integrators will find the creation of OpenIDM projects much simpler to manage.

##Requirements

The only fixed requirement necessary to use this boilerplate is [Vagrant](http://www.vagrantup.com/). By default, Vagrant is configured to use [VirtualBox](https://www.virtualbox.org/) as the virtual machine provider; unless you really want to use a different provider, you should have that installed as well (check [Vagrant](http://www.vagrantup.com/ for more details on using others).

To get the most value out of this boilerplate, you should check it into a source code manager such as git or subversion. This way you can track your project customizations just like you would track any other development project. Git will probably work the best, as I have already prepped the .gitignore as you would need.

You will probably also need some kind of IDE (Eclipse, Sublime Text, etc...) for development.

##Getting started

Download (or fork & clone) this project into your local environment. Add it to your source control as needed. Once you have the above requirements installed, just run one command:

    vagrant up

This will take a while to download the base image and all of the many dependencies. Once it has finished, you will have the software running in a set of VMs. You can now access your local server at [https://localhost:8443/openidmui/](https://localhost:8443/openidmui/) and [https://localhost:8443/admin/](https://localhost:8443/admin/). Until you start customizing the project, all you will have is the stock OpenIDM project, with the only difference being that it is configured to use PostgreSQL as the repository. The PostgreSQL database server is running in a separate VM (called 'postgresql93'). Both of these VM images are Ubuntu 'Precise' (12.04.5) 32-bit servers.

When the vagrant environment is first created, [Maven](http://maven.apache.org/) is used within your 'idm' vm to compile all of the project source (under src/main/resources) and the dependencies into the target/openidm_project folder. After that finishes, OpenIDM is registered as a service and then started. Finally, [Grunt](http://gruntjs.com/) is used to monitor changes to the source code and automatically deploy that to the target/openidm_project folder.

At this point, whatever specific customizations that exist for your project will be deployed and ready to use. Whoever else has access to your project source code should be able to bring online the complete environment with just that one command. If no further development is needed, then the system is ready to use as it is when it starts up.

##Project Development

Nearly all of the files included in this boilerplate are likely candidates for changes. It is my hope that what is provided is a reasonable default for most starting points, but it is worth looking through each folder and seeing what files are already there. I have included READMEs in each folder as well, with a brief explanation about what you might want to do with each of the provided files and folders. I have also added a fair amount of comments in each file, where I think it is most likely that you will need to change them. I highly suggest looking through each file that I am including.

There are several files within this root folder that you should be aware of:

###Vagrantfile
This file is used by [Vagrant](http://www.vagrantup.com/) to define all of the virtual machines you want to use to run your project. Given that this project is designed to facilitate development of a project, I highly recommend using these virtual machines as targets for your whole environment (not just for OpenIDM itself but also all of the remote resources you expect to connect to). If this is feasible, having your whole environment defined with vagrant will be very advantageous as it allows anyone who checks out your project to have an identical, independent copy of what you used during your development. Setting this up means adding new virtual machine entries within Vagrantfile, along with the necessary provisioner configuration (shell scripts, Chef / Puppet configurations, etc...) to get the server in a usable state.

###pom.xml
This file is used by [Maven](http://maven.apache.org/) within the 'idm' machine. It instructs Maven to pull together the OpenIDM core, any external dependencies you need (JDBC drivers, libraries, etc...) and your project source into a single folder (target/openidm_project). Note that Maven is only executed when the idm machine is first created. If you need to make changes to pom.xml, you will probably need to login to the virtual machine and re-execute maven, manually. For example:

    vagrant ssh idm
    cd /vagrant
    mvn clean install

I recommend getting pretty familiar with this process. It often seems to be helpful to operate within the VM running OpenIDM, for troubleshooting / restarting / rebuilding etc...

###Gruntfile.js and package.json
These files configure [Grunt](http://gruntjs.com/), which runs in the background of the 'idm' VM. Grunt is helpful for many things, but by default I have only configured it to automatically deploy changes from your src/main/resources working copy into your target/openidm_project build environment. This may be all you need, however sometimes more complex build processes may be needed (Javascript minification for the UI, for example). Edit these two files in the normal way to customize the build process however you need.


