DELETE FROM mysql.user WHERE Host = '%' AND User = 'circleci';
CREATE USER 'circleci'@'%' IDENTIFIED BY '';
GRANT ALL ON *.* TO 'circleci'@'%' WITH GRANT OPTION;
