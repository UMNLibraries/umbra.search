# Using Podman with Umbra Search

At present, we are testing Podman as part of creating a development environment. Hence, these instructions are geared towards that use case.

_helpful reminder_: you will need to rebuild the containers when you make changes to the application code ;)

## Environment

- Install [Podman Desktop](https://podman-desktop.io/downloads) for `podman` and `docker-compose` or use the package manager of your choice
    - _MacOS_: using Podman Desktop is encouraged for simplicity's sake
- clone the relevant repositories if you haven't already
    - https://github.com/UMNLibraries/umbra.search
    - https://github.com/UMNLibraries/umbra_solr_core
- for the `umbra.search` repository: `git checkout podman` 
- ensure that the podman and docker-compose binaries are in your PATH.
    - _MacOS_: `export PATH="/opt/podman/bin:/usr/local/bin:/usr/local/podman/helper/$USER:$PATH"`
- MacOS users will need to create a podman VM with `podman machine init --cpus 2 --memory 4096`

## Building

1. Ensure your environment is correct as per the above
2. _MacOS only_: ensure the podman machine is running with `podman machine start`
3. Change into the `umbra_solr_core` folder and run `./rebuild-podman`
4. Change into the `umbra.search` folder -- double check you are on the `podman` git branch
5. `cp .env-example .env`
6. `mkdir thumbnails`
7. `docker-compose build`
    - this step may fail, if it does, simply run it again and it should succeed
    - this step will feature many scary depreciation warnings; for the time being, ignore them
8. `docker-compose up`
    - this will take a bit
9. create the MySQL DB:  `docker-compose run web rake db:create`
10. setup the DB: `docker-compose run web rake db:migrate && docker-compose run web rake db:seed
11. navigate to `localhost:3000` in a browser, you should be greeted by a blank umbrasearch web interface

## Everyone Loves Solr

