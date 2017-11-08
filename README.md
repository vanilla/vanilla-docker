## Vanilla Docker environment

*Only supports Mac OSX at the moment but everything can be easily adapted to work on other platforms.*
*Assume that you are using [PhpStorm](https://www.jetbrains.com/phpstorm/) as your IDE.*

This repository contains a ready-for-development environment to develop against Vanilla.

## The containers

### db 
*This container also has the alias "database".*

Percona SQL database.

- Accessible from the container with the hosts "db" or "database"
- Accessible from the docker host machine with the hosts "db", "database", "localhost", "127.0.0.1'
- The user is "root" and there is no password.

### httpd

Apache 2 web server.

- Accessible with the port 9080 and 9443
- Serve https://dev.vanilla.localhost:9443

### nginx

nginx web server

- Serve:
    - https://dev.vanilla.localhost (main forum)
    - https://sso.vanilla.localhost (sso providers)
    - http://vanilla.test:8080 (unit tests address)

### php-fpm

php-fpm with PHP 7.1

## Setup

*For this setup to work properly you need to clone all vanilla repositories in the same base directory*

1. Get [Docker for OSX](https://download.docker.com/mac/stable/Docker.dmg) and install it.
1. Create a `repositories` folder
1. Clone all the wanted repositories in there.
    - [https://github.com/vanilla/vanilla](vanilla/vanilla)
        - It is recommended to use "vanilla_dev" as the database name since some services are configured to use that database.
    - [https://github.com/vanilla/vanilla-docker](vanilla/vanilla-docker)
    - [https://github.com/vanilla/addons](vanilla/addons)
    - ...
1. Move into the `vanilla-docker` directory.
1. Run `sudo ./mac-setup.sh` which will:
    - Add a self signed certificate `*.vanilla.localhost` to your keychain.
    - Safely update your `/etc/hosts`.
    - Add `192.0.2.1` as a loopback IP address.
    - Create a docker volume named "datastorage" which will contain the database data.
1. Run `docker-compose up --build` (It will take a while the first time) and voila -> [dev.vanilla.localhost](https://dev.vanilla.localhost/)

Do not forget to run `docker-compose up --build` to start up the services every time you restart your computer.
To properly stop the containers you need to run `docker-compose down`.

### Xdebug

See [Make Xdebug work with PhpStorm](./docs/xdebug.md).

### Unit tests

See [Make unit tests work within PhpStorm](./docs/unit-tests.md).

## F.A.Q

Q. Why is everything so low?
A. Maybe you did not allocate enough Memory and CPUs to docker. `Docker` > `Preferences` > `Advanced`
