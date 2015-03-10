#!/usr/bin/env bash

# Usage
# Login as root
# ./provision.sh local_mysql_password localdb_name

# Update
apt-get update

# MySQL root password from input
debconf-set-selections <<< "mysql-server mysql-server/root_password password $1"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $1"

apt-get install -qq mysql-server

printf '\n%s' 'server-id = 2' >> /etc/mysql/my.cnf
printf '\n%s' 'log-bin = /var/lib/mysql/bin-log' >> /etc/mysql/my.cnf
printf '\n%s' 'log-slave-updates = 1' >> /etc/mysql/my.cnf

service mysql restart

mysql -u root -p$1 -e "CREATE DATABASE $2";