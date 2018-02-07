## Vanilla Docker environment

*Only supports Mac OSX at the moment but everything can be easily adapted to work on other platforms.*
*Assume that you are using [PhpStorm](https://www.jetbrains.com/phpstorm/) as your IDE.*

This repository contains a ready-for-development environment to develop against Vanilla.

## The containers

### perconadb / mariadb

SQL database.

- Accessible from the container with the hosts "database".
- Accessible from the docker host machine with the hosts "database", "localhost", "127.0.0.1'
- The user is "root" and there is no password.

Defaults to perconadb.
To change that set the environment variable VANILLA_DOCKER_DATABASE to mariadb in your `.bash_profile`.

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

php-fpm with PHP 7.2

## Setup

*For this setup to work properly you need to clone all vanilla repositories in the same base directory*

1. Get [Docker for OSX](https://download.docker.com/mac/stable/Docker.dmg) and install it.
    - Do not forget to tune up the allocated Memory and CPUs. `Docker` > `Preferences` > `Advanced`
1. Create a `repositories` folder
1. Clone all the wanted repositories in there.
    - [https://github.com/vanilla/vanilla](vanilla/vanilla)
        - It is recommended to use "vanilla_dev" as the database name since some services are configured to use that database.
    - [https://github.com/vanilla/vanilla-docker](vanilla/vanilla-docker)
    - [https://github.com/vanilla/addons](vanilla/addons)
    - ...
1. You should have the following structure
```
repositories
├── vanilla
├── vanilla-docker
├── addons
├── ...
```
1. Move into the `vanilla-docker` directory.
1. Run `sudo ./mac-setup.sh` which will:
    - Add a self signed certificate `*.vanilla.localhost` to your keychain.
    - Safely update your `/etc/hosts`.
    - Add `192.0.2.1` as a loopback IP address.
    - Create a docker volume named "datastorage" which will contain the database data.
1. Run `docker-compose up --build` (It will take a while the first time) and voila -> [dev.vanilla.localhost](https://dev.vanilla.localhost/)

Do not forget to run `docker-compose up --build` to start up the services every time you restart your computer.
To properly stop the containers you need to run `docker-compose down`.

##### Running optional services

To run additional services (named service-*.yml) you can specify which .yml file to run like so:

`docker-compose -f docker-compose.yml -f docker-compose.override.yml -f service-sphinx.yml up --build`

You can add as many services as you want that way.
For more information: [understanding-multiple-compose-files](https://docs.docker.com/compose/extends/#understanding-multiple-compose-files)

##### Using your local database

To start all container but the database one you can use:

`docker-compose -f docker-compose.yml up --build`

This will skip `docker-compose.override.yml`. Note that by doing so you will probably have to add additional
configurations to make sure that the database is reachable from the containers.

To address that issue you have 2 ways of doing it:
- You always have the possibility of using the loopback ip `192.0.2.1` that is installed by the `mac-setup.sh` script
if your database is installed directly on your machine.
- You can also create custom.*.yml file to extends the existing services and add extra-hosts to the services. Example:
    `custom.dbhost.yml`
    ```
    version: "3"
    
    services:
        phpfpm:
            extra_hosts:
                database: 192.0.2.1

    ```
    You can then do: `docker-compose -f docker-compose.yml -f custom.dbhost.yml up --build`

You can also delete the datastorage volume created by `mac-setup.sh` since you won't be using it.

### Xdebug

See [Make Xdebug work with PhpStorm](./docs/xdebug.md).

### Unit tests

See [Make unit tests work within PhpStorm](./docs/unit-tests.md).

## F.A.Q

Q. Why is everything so slow?

A. You are probably running on the APFS file system that became the standard with macOS High Sierra and 
which has pretty bad performance with Docker for Mac. 
Having the database on your host instead os inside docker might help a lot. See [#10](https://github.com/vanilla/vanilla-docker/issues/10). 

