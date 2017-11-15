DELETE FROM mysql.user WHERE Host = '%' AND User = 'travis';
CREATE USER 'travis'@'%' IDENTIFIED BY '';
GRANT ALL ON *.* TO 'travis'@'%' WITH GRANT OPTION;
