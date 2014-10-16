#!/bin/bash

export OPENIDM_OPTS="-Xms128m -Xmx256m"

echo "192.168.50.4 OPENIDM_REPO_HOST" >> /etc/hosts

echo "export OPENIDM_OPTS=\"${OPENIDM_OPTS}\"" >> /etc/profile

apt-get --yes update

apt-get --yes --force-yes install python-software-properties
add-apt-repository --yes ppa:webupd8team/java
add-apt-repository --yes ppa:chris-lea/node.js

apt-get --yes update

echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

apt-get --yes --force-yes install oracle-java7-installer maven postgresql-client subversion nodejs

npm install -g grunt-cli

# if you want a specific build of OpenIDM, uncomment the the below lines and adjust as necessary
# be sure that the reference in pom.xml matches the version you build

#cd /tmp
#svn checkout https://svn.forgerock.org/openidm/tags/3.0.0 openidm
#cd openidm
#mvn clean install

cd /vagrant
mvn clean install
npm install
cd target/openidm_project/bin
./create-openidm-rc.sh
cp openidm /etc/init.d