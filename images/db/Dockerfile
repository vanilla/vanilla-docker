FROM percona:latest

COPY etc/mysql/conf.d/config-file.cnf /etc/mysql/conf.d/config-file.cnf
COPY docker-entrypoint-initdb.d/travis.sql /docker-entrypoint-initdb.d/travis.sql
