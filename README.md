## What's this?

A work in progress!

### TODO
- Create a script that will create/update docker-compose.yml properly 

## Setup

We only support Mac OSX for the moment.

1. Get [Docker for OSX](https://download.docker.com/mac/stable/Docker.dmg).
1. `sudo ./mac-setup.sh`
1. Copy docker-compose.yml.tpl to docker-compose.yml and replaces variables in it. ie {PATH_TO_VANILLA}
1. Add ./logs to the docker File Sharing directories.

### Xdebug

See [Make PhpStorm work with Xdebug](./docs/xdebug.md).

## Using It

## Tips and Gotchas

To reference to database (on your laptop and inside the containers)
you just have to use `database` as the hostname.

## Troubleshooting

