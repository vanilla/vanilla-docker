FROM mariadb:10.2


COPY etc/mysql/conf.d/config-file.cnf /etc/mysql/conf.d/config-file.cnf
COPY docker-entrypoint-initdb.d/* /docker-entrypoint-initdb.d/
