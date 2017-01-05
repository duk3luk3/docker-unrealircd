unrealircd-3.2
==============

UnrealIRCD with Anope Services

# preparation

## SSL

Put SSL cert and key to `server.cert.pem` and `server.key.pem`.

For testing, create self-signed certificate:

    openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout server.key.pem -out server.cert.pem

## Secrets

Copy `secrets.sh.sample` to `secrets.sh` and adjust values.

To create secret strings, use e.g.

    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 50 | head -n 1

## Build configuration

Copy `config.settings.sample` to `config.settings` and adjust.

# usage

    docker run dockerimages/docker-unrealircd
  
