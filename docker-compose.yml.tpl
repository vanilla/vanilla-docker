version: "3"
services:

  db:
    build:
      context: "./images/db"
    environment:
      MYSQL_ALLOW_EMPTY_PASSWORD: "yes"
    image: "percona:latest"
    ports:
      - "3306:3306"
    volumes:
      - ./logs/mysql:/var/log/mysql

  fcgi:
    build:
      context: "./images/fcgi"
    depends_on:
      - "db"
    volumes:
      - {PATH_TO_VANILLA}:/srv/htdocs
      - shared:/var/run
      - ./logs/php-fpm:/var/log/php-fpm

  httpd:
    build:
      context: "./images/httpd"
    depends_on:
      - "fcgi"
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - {PATH_TO_VANILLA}:/srv/htdocs
      - shared:/var/run
      - ./logs/nginx:/var/log/nginx

volumes:
  shared:
