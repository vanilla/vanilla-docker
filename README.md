## Vanilla Docker environment

_Only supports Mac OSX at the moment but everything can be easily adapted to work on other platforms._
_Assume that you are using [PhpStorm](https://www.jetbrains.com/phpstorm/) as your IDE._

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

php-fpm with PHP 7.3

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
- if your environment or tasked to be different you need to change `install-sphinx-cron.sh`
  accordingly

Note that the easiest way to run this script is through docker:

```
docker exec -t sphinx bash /root/install-sphinx-cron.sh
```

## Setup

_For this setup to work properly you need to clone all vanilla repositories in the same base directory_

1. Get [Docker for OSX](https://download.docker.com/mac/stable/Docker.dmg) and install it.

   - Do not forget to tune up the allocated Memory and CPUs. `Docker` > `Preferences` > `Advanced`

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
1. Run `vanilla-docker/bin/mac-setup` which will:
   - Install the following dependencies if not already configured.
     - Brew
     - PHP
     - Composer
     - Node
     - Yarn
     - docker-sync
     - unison
   - Configure your local machine for docker. This will prompt your for your user password.
     - Add a self signed certificate `*.vanilla.localhost` to your keychain.
     - Safely update your `/etc/hosts`.
     - Add `192.0.2.1` as a loopback IP address.
     - Create a docker volume named "datastorage" which will contain the database data.
   - Create 2 aliases for starting and stopping vanilla-docker. These can be run from anywhere on your machine.
     - vanilla-start
     - vanilla-stop
1. Move into the `vanilla` directory.
1. Run `composer install` which will install Vanilla's dependencies.
1. Run `vanilla-start` (It will take a while the first time). You'll know it worked if you see something like
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

### Stopping Docker

To properly stop the containers run `vanilla-stop`

## Updating an existing vanilla-docker installation

- Pull the latest version of `vanilla-docker`
- Restart docker entirely.

  ![image](https://user-images.githubusercontent.com/1770056/82736370-4a8f9380-9cf7-11ea-8f18-26f965e9abe1.png)

- Navigate to `vanilla-docker`
- Run `bin/mac-setup` (even if you already ran it before).
- Run `vanilla-start` from anywhere.

### Updating to a RAW data format

You may see a message "It looks like your docker volume is not in the RAW format." when trying to proceed with your upgrade.

In order to changer to the RAW data format for docker, you need to do the following:

- Backup any databases you have.
- Open the docker troubleshooting page. (Open docker settings, click the "Bug" icon next to settings.)
- Click on `Reset disk image`.
- Wait until that completes.
- Run the setup script again.
- Start docker `vanilla-start`.
- Restore your databases.

##### Running optional services

To run additional services (named service-\*.yml) you can specify which .yml file to run like so:

```shell
docker-compose -f docker-compose.yml -f docker-compose.override.yml -f service-sphinx.yml up --build
```

You can add as many services as you want that way.
_You can create a script named custom.boot.sh, with the combination of services that you want, so that it is easier to start the services that you want._

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
- You can also create custom.\*.yml file to extends the existing services and add extra-hosts to the services. Example:
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

Q. My syncronization seems to not be working.

A. There are multiple reasons the sync could fail. The primary one being that you are mounting too many files into your volume. If you have files in the parent directory of vanilla-docker that are not related to _running_ vanilla, it's recommended to move these.

Another reason might be mass-modification of files. If you modify 100k+ files at once, with a command like `chmod -r` or `chown -r` then you will likely need to reset your sync.

These are the methods that you can use to troubleshoot, in order of fastest to slowest.

- Restart vanilla-docker and docker.
  - `vanilla-stop`
  - Docker Menu -> Restart
  - Wait for restart to finish...
  - `vanilla-start`
- Reboot your computer.
- Reset your sync.
  - `vanilla-stop`
  - Docker Menu -> Restart
  - Wait for restart to finish...
  - `cd /path/to/vanilla-docker && docker-sync clean`
  - `vanilla-start`
