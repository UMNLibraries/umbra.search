# Umbra Customizations/Podman Desktop

## using Podman Desktop

- ensure podman binaries are in the PATH
    - eg., `export PATH="/opt/podman/bin:/opt/podman/qemu/bin:/usr/local/podman/helper/$USER/podman-mac-helper:$PATH"`

## Linux Buildkit

Adding `DOCKER_BUILDKIT=0` to `docker-compose up` 

eliminated the error: `failed to receive status: rpc error: code = Unavailable desc = error reading from server: read unix @->/run/user/1000/podman/podman.sock: read: connection reset by peer`

## DOCKER_HOST env

`export DOCKER_HOST=unix:///run/user/$UID/podman/podman.sock`

https://brandonrozek.com/blog/rootless-docker-compose-podman/

# Solr setup

1. docker-compose run web rake indexer:dev_run
2. docker-compose run web rake solr:commit
3. docker-compose run web rake solr:suggest_build



