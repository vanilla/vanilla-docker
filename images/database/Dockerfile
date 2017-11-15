FROM percona:5.7

COPY etc/mysql/percona-server.conf.d/z_config-file.cnf /etc/mysql/percona-server.conf.d/z_config-file.cnf
COPY docker-entrypoint-initdb.d/travis.sql /docker-entrypoint-initdb.d/travis.sql
