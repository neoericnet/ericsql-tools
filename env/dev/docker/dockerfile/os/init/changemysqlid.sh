#!/bin/bash
set +e

##define vars
new_mysql_uid=$1
new_mysql_gid=$2
old_mysql_uid=$(id -u mysql)
old_mysql_gid=$(id -g mysql)

##change
usermod -u $new_mysql_uid mysql
groupmod -g $new_mysql_gid mysql
chown -R mysql:mysql /soft/mysql
chown -R mysql:mysql /data/mysql
