#!/bin/bash

export OPENIDM_OPTS="-Xms128m -Xmx256m"

echo "192.168.50.4 OPENIDM_REPO_HOST" >> /etc/hosts

echo "export OPENIDM_OPTS=\"${OPENIDM_OPTS}\"" >> /etc/profile

apt-get --yes update

## Uncomment the following lines to install Oracle JDK instead of openjdk
#apt-get --yes --force-yes install python-software-properties
#add-apt-repository --yes ppa:webupd8team/java

#apt-get --yes update

# Uncomment the below line to upgrade all of the system packages. Warning: takes a while
#apt-get --yes upgrade

#echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
#echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

#apt-get --yes --force-yes install oracle-java7-installer

# Below is for OpenJDK; comment this line out if you want Oracle JDK
apt-get --yes --force-yes install openjdk-7-jdk

# You will always need the below three lines
apt-get --yes --force-yes install maven npm
ln -s /usr/bin/nodejs /usr/bin/node
npm install -g grunt-cli

# If you want a specific version of OpenIDM that isn't publish on ForgeRock's maven repository,
# uncomment the the below lines and adjust as necessary be sure that the reference in pom.xml
# matches the version you build:
#apt-get --yes --force-yes install subversion
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
