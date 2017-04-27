## What's this?

A work in progress!

### TODO
- Create a script that will create/update docker-compose.yml properly 

## Setup

1. Get [Docker for OSX](https://download.docker.com/mac/stable/Docker.dmg).
1. Copy docker-compose.yml.tpl to docker-compose.yml and replaces variables in it. ie {PATH_TO_VANILLA}
1. Add ./logs to the docker File Sharing directories.

### Xdebug

See [Make PhpStorm work with Xdebug](./doc/xdebug.md).

## Using It

## Tips and Gotchas

If you want to reference the Database from PHP you have to put the name of the service as the host.
In this case 'db'.

## Troubleshooting

