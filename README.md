## Vanilla Docker environment

*Only supports Mac OSX at the moment but everything can be easily adapted to work on other platforms.*
*Assume that you are using [PhpStorm](https://www.jetbrains.com/phpstorm/) as your IDE.*

This repository contains a ready-for-development environment to develop against Vanilla.

## The containers

### db 
*This container also has the alias "database".*

Perconna SQL database.

- Accessible from the container with the hosts "db" or "database"
- Accessible from the docker host machine with the hosts "db", "database", "localhost", "127.0.0.1'

### httpd

Apache 2 web server.

- Accessible with the port 9080 and 9443
- Serve https://dev.vanilla.localhost

### nginx

nginx web server

- Serve:
    - https://dev.vanilla.localhost (main forum)
    - https://sso.vanilla.localhost (sso providers)
    - http://vanilla.test (unit tests address)

### php-fpm

php-fpm with PHP 7.1

## Setup

1. Clone this repository in the same folder than [https://github.com/vanilla/vanilla](vanilla/vanilla)
1. Get [Docker for OSX](https://download.docker.com/mac/stable/Docker.dmg).
1. Run `sudo ./mac-setup.sh` which will:
    - Install a self signed certificate for `*.vanilla.localhost`
    - Safely update your `/etc/hosts`.
    - Add `192.0.2.1` as a loopback ip address.
    - Create a docker volume named "datastorage" which will contain the database data.
1. Run `docker-compose up --build` and voila -> [dev.vanilla.localhost](https://dev.vanilla.localhost/)

### Xdebug

See [Make Xdebug work with PhpStorm](./docs/xdebug.md).

### Unit tests

See [Make unit tests work within PhpStorm](./docs/unit-tests.md).
