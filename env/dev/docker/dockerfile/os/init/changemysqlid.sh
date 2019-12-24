#!/bin/bash
set -e

##define vars
new_mysql_uid=$1
new_mysql_gid=$2
old_mysql_uid=$(id -u mysql)
old_mysql_gid=$(id -g mysql)

##change
usermod -u $new_mysql_uid mysql
groupmod -g $new_mysql_gid mysql
find / -user $old_mysql_uid -exec chown -h mysql {} \;
find / -group $old_mysql_gid -exec chgrp -h mysql {} \;
