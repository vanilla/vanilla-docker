#
# I NEED TO RE-TEMPLATE THIS
#
version: "3"
services:

  db:
    build:
      context: "./images/db"
    container_name: vanilladocker_db
    environment:
      MYSQL_ALLOW_EMPTY_PASSWORD: "yes"
    ports:
      - "3306:3306"
    volumes:
      - shared:/shared
      - ./logs/mysql:/var/log/mysql
      - datastorage:/var/lib/mysql

  httpd:
    build:
      context: "./images/httpd"
    container_name: vanilladocker_httpd
    depends_on:
      - "db"
      - "php_fpm"
    ports:
      - "9080:9080"
      - "9443:9443"
    volumes:
      - shared:/shared
      - ./logs/httpd:/var/log/httpd
      - ~/workspace/repos:/srv/vanilla-repositories

  nginx:
    build:
      context: "./images/nginx"
    container_name: vanilladocker_nginx
    depends_on:
      - "db"
      - "php_fpm"
    ports:
      - "80:80"
      - "8080:8080"
      - "443:443"
    volumes:
      - shared:/shared
      - ./logs/nginx:/var/log/nginx
      - ~/workspace/repos:/srv/vanilla-repositories

  php_fpm:
    build:
      context: "./images/php-fpm"
    container_name: vanilladocker_phpfpm
    links:
      # Allow to use "database" as a hostname from php
      - "db:database"
    volumes:
      - shared:/shared
      - ./logs/php-fpm:/var/log/php-fpm
      - ~/workspace/repos:/srv/vanilla-repositories
    extra_hosts:
      - machinehost:192.0.2.1

volumes:
  datastorage:
    # Created by our setup
    external: true
  shared:
