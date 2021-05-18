FROM percona:5.7-alpine

COPY etc/mysql/my.cnf /etc/mysql/my.cnf
COPY docker-entrypoint-initdb.d/* /docker-entrypoint-initdb.d/
