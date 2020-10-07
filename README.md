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
    - https://vanilla.localhost/dev (directory-based main forum, see [the docs](docs/vanilla-localhost-dirs.md))
    - https://sso.vanilla.localhost ([stub-sso-providers](https://github.com/vanilla/stub-sso-providers))
    - https://embed.vanilla.localhost ([stub-embed-providers](https://github.com/vanilla/stub-embed-providers))
    - https://advanced-embed.vanilla.localhost ([stub-embed-providers](https://github.com/vanilla/stub-embed-providers))
    - http://vanilla.test:8080 (unit tests address)

### php-fpm

php-fpm with PHP 7.4 and syslogd.

The php-fpm container comes in two flavours, `standard` and `xdebug`.
The nginx container takes care of routing the request to the appropriate php-fpm flavour based on if your request needs debugging or not.

Both versions integrate `syslogd` to support PHP's `syslog()`. Syslog is tailed to `stdout` and it is prompted by `docker-compose` in the usual way (`docker-compose logs -f`, `docker-compose up --build`, etc)

### Sphinx

Sphinx search service (service-sphinx.yml).

#### Installing Sphinx

Before enabling make sure that:
- Your database is named vanilla_dev
- You have set `Plugins.Sphinx.Server = sphinx` in your config
- You have set `Plugins.Sphinx.SphinxAPIDir = /sphinx/` in your config
- You have enabled the sphinx plugin
- You symlinked one of the [configs-available](./resources/usr/local/etc/sphinx/configs-available) as sphinx.conf in resources/usr/local/etc/sphinx/conf.d
- Example from conf.d/: `ln -s configs-available/standard.sphinx.conf sphinx.conf`
- For unit tests use the everything.sphinx.conf

#### Sphinx unit testing config
- Ensure you have a test database `vanilla_test`.
- Ensure you are using the `everything.sphinx.conf` config for sphinx.
- Ensure that your phpunit.xml and phpunit.dist.xml have the following environmental value:
`<env name="TEST_SPHINX_HOST" value="sphinx" />`

#### Re-indexing your database

There are a couple of handly scripts to run the re-indexer. You can run them from the command line like so:

```
docker exec -t sphinx bash /root/index.delta.sh
docker exec -t sphinx bash /root/index.all.sh
```

#### Installing the Sphinx indexr crontab

If you need to have Sphinx indexes updated regularly run [install-sphinx-cron.sh](./images/sphinx/root/install-sphinx-cron.sh).
- by default it will reindex delta indexes every minute and reindex all indexes every 5 min.
- by default cron jobs hit `sphinx` container
- if your environment or tasked to be different you need to change  `install-sphinx-cron.sh`
 accordingly

 Note that the easiest way to run this script is through docker:

 ```
docker exec -t sphinx bash /root/install-sphinx-cron.sh
 ```

## Setup

*For this setup to work properly you need to clone all vanilla repositories in the same base directory*

1. Get [Docker for OSX](https://download.docker.com/mac/stable/Docker.dmg) and install it.

    - Do not forget to tune up the allocated Memory and CPUs. `Docker` > `Preferences` > `Advanced`
1. Get [Brew, Yarn & Node](https://staff.vanillaforums.com/kb/articles/135-install-node-yarn)
1. Get [Composer](https://getcomposer.org/) and install it.
1. Create a directory for your project. In this example, we'll use `my-vanilla-project`, but you can use any name.
1. Move into your project directory.
1. Clone or download [vanilla/vanilla-docker](https://github.com/vanilla/vanilla-docker) into your project directory.
1. Clone or download [vanilla/vanilla](https://github.com/vanilla/vanilla) into your project directory.
1. Clone or download any other project dependencies into your project directory (for example, any of [vanilla/addons](https://github.com/vanilla/addons)), and install according to their instructions. _Note: All addons, plugins, themes, etc, must be located in the project directory. Everything outside of the project directory will not be made available inside of the Docker container._
1. You should have the following structure
    ```
    my-vanilla-project
    ├── vanilla
    ├── vanilla-docker
    ├── ...
    ```
1. Move into the `vanilla` directory.
1. Run `composer install` which will install Vanilla's dependencies.
1. Move up and over into the `vanilla-docker` directory.
1. Run `sudo ./mac-setup.sh` which will:
    - Add a self signed certificate `*.vanilla.localhost` to your keychain.
    - Safely update your `/etc/hosts`.
    - Add `192.0.2.1` as a loopback IP address.
    - Create a docker volume named "datastorage" which will contain the database data.
1. Run `docker-compose up --build` (It will take a while the first time). You'll know it worked if you see something like
    ```
    Successfully built…
    Successfully tagged…
    Creating database ... done
    Creating php-fpm  ... done
    Creating httpd    ... done
    Creating nginx    ... done
    Attaching to database, php-fpm, httpd, nginx
    …
    php-fpm     | done.
    ```
    and voila -> [dev.vanilla.localhost](https://dev.vanilla.localhost/) shows the Vanilla installer.
1. Run the installer!

    - It is recommended to use `vanilla_dev` as the database name since some services are configured to use that database.
    - It is recommended to use `database` for the host name.
    - It is recommended to use `root` as the username.

To properly stop the containers you need to run `docker-compose down`.

Do not forget to run `docker-compose up --build` to start up the services every time you restart your computer.

##### Running optional services

To run additional services (named service-*.yml) you can specify which .yml file to run like so:

```shell
docker-compose -f docker-compose.yml -f docker-compose.override.yml -f service-sphinx.yml up --build
```

You can add as many services as you want that way.
*You can create a script named custom.boot.sh, with the combination of services that you want, so that it is easier to start the services that you want.*

Generally, there should be documentation inside the .yml file of the service that gives you information about it.

For more information: [understanding-multiple-compose-files](https://docs.docker.com/compose/extends/#understanding-multiple-compose-files)

##### Using your local database

To start all containers except the database one you can use:

```shell
docker-compose -f docker-compose.yml up --build
```

This will skip `docker-compose.override.yml`. Note that by doing so you will probably have to add additional configurations to make sure that the database is reachable from the containers.

To address that issue you have 2 ways of doing it:
- You always have the possibility of using the loopback ip `192.0.2.1` that is installed by the `mac-setup.sh` script if your database is installed directly on your machine.
- You can also create custom.*.yml file to extends the existing services and add extra-hosts to the services. Example:
    `custom.dbhost.yml`
    ```yaml
    version: "3"

    services:
        php-fpm:
            extra_hosts:
                database: 192.0.2.1

    ```
    You can then do:
    ```shell
    docker-compose -f docker-compose.yml -f custom.dbhost.yml up --build
    ```

You can also delete the datastorage volume created by `mac-setup.sh` since you won't be using it.

### Xdebug

See [Make Xdebug work with PhpStorm](./docs/xdebug.md).

### Unit tests

See [Make unit tests work within PhpStorm](./docs/unit-tests.md).

## F.A.Q

Q. Why is everything so slow?

A. You are probably running on the APFS file system that became the standard with macOS High Sierra and which has pretty bad performance with Docker for Mac.
Having the database on your host instead of inside docker might help a lot. See [#10](https://github.com/vanilla/vanilla-docker/issues/10).
