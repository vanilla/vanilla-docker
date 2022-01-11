## Vanilla Docker environment

*Only supports Mac OSX at the moment but everything can be easily adapted to work on other platforms.*
*Assume that you are using [PhpStorm](https://www.jetbrains.com/phpstorm/) as your IDE.*

This repository contains a ready-for-development environment to develop against Vanilla.

## The containers

### database

SQL database.

- Accessible from the container with the hosts "database".
- Accessible from the docker host machine with the hosts "database", "localhost", "127.0.0.1'
- The user is "root" and there is no password.

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

php-fpm with PHP 7.4 and rsyslogd.

The php-fpm container comes in two flavours, `standard` and `xdebug`.
The nginx container takes care of routing the request to the appropriate php-fpm flavour based on if your request needs debugging or not.

**_When XDebug is running things are much slower. As a result it recommended not pass an XDebug cookie (normally through a browser extension) unless you are actively debugging._**

## Setup

https://success.vanillaforums.com/kb/articles/155-local-setup-quickstart

### Xdebug

See [Make Xdebug work with PhpStorm](./docs/xdebug.md).

### Unit tests

See [Make unit tests work within PhpStorm](./docs/unit-tests.md).

## F.A.Q

Q. Why is everything so slow?

A. You are probably running on the APFS file system that became the standard with macOS High Sierra and which has pretty bad performance with Docker for Mac.
Having the database on your host instead of inside docker might help a lot. See [#10](https://github.com/vanilla/vanilla-docker/issues/10).
