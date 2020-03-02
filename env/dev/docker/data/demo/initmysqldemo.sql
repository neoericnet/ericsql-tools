alter user 'root'@'localhost' identified by 'test';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'test' WITH GRANT OPTION;
FLUSH PRIVILEGES;
