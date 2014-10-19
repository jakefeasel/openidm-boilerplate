#!/bin/bash

# This file creates a PostgreSQL database server and initializes the OpenIDM repository within that server

export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
apt-get --yes update

# Uncomment the below line to upgrade all of the system packages. Warning: takes a while
#apt-get --yes upgrade

apt-get --yes --force-yes install postgresql-9.3 postgresql-contrib-9.3

pg_dropcluster --stop 9.3 main
echo "listen_addresses = '*'" >> /etc/postgresql-common/createcluster.conf
pg_createcluster --start -e UTF-8 --locale en_US.UTF-8 9.3 main -- --auth-local=trust
echo "host    all             all             10.0.0.0/16            md5" >> /etc/postgresql/9.3/main/pg_hba.conf
echo "host    all             all             192.168.50.0/24            md5" >> /etc/postgresql/9.3/main/pg_hba.conf
service postgresql reload

echo "alter user postgres with password 'password';" | psql -U postgres
iptables -A INPUT -p tcp --dport 5432 -j ACCEPT

# initialize the openidm repository
psql -U postgres < /vagrant/src/main/resources/db/openidm/createuser.pgsql
psql -U openidm < /vagrant/src/main/resources/db/openidm/openidm.pgsql

# Include the custom schema optimizations for this project
psql -U postgres openidm < /vagrant/src/main/resources/db/openidm/custom_schema_optimizations.pgsql
