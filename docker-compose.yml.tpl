version: "3"
services:

  db:
    build:
      context: "./images/db"
    container_name: vanilladocker_db
    environment:
      MYSQL_ALLOW_EMPTY_PASSWORD: "yes"
    image: "percona:latest"
    ports:
      - "3306:3306"
    volumes:
      - shared:/var/lib/mysql
      - ./logs/mysql:/var/log/mysql

  fcgi:
    build:
      context: "./images/fcgi"
    container_name: vanilladocker_fcgi
    depends_on:
      - "db"
    volumes:
      - {PATH_TO_VANILLA_REPOSITORIES}:/src/vanilla-repositories
      - shared:/var/run
      - ./logs/php-fpm:/var/log/php-fpm

  httpd:
    build:
      context: "./images/httpd"
    container_name: vanilladocker_httpd
    depends_on:
      - "fcgi"
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - {PATH_TO_VANILLA_REPOSITORIES}:/src/vanilla-repositories
      - shared:/var/run
      - ./logs/nginx:/var/log/nginx

volumes:
  shared:
