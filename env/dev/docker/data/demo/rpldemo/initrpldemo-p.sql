SET SQL_LOG_BIN=0;
alter user 'root'@'localhost' identified by 'test';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'test' WITH GRANT OPTION;
CREATE USER rpl_user@'%' IDENTIFIED BY 'test';
GRANT REPLICATION SLAVE ON *.* TO rpl_user@'%';
FLUSH PRIVILEGES;
SET SQL_LOG_BIN=1;
