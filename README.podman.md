# Using Podman with Umbra Search

At present, we are testing Podman as part of creating a development environment. Hence, these instructions are geared towards that use case.

### Environment

#### MacOS

- Install [Podman Desktop](https://podman-desktop.io/downloads) for `podman` and `docker-compose`
    - using Podman Desktop is encouraged for simplicity's sake
- clone the relevant repositories if you haven't already
    - https://github.com/UMNLibraries/umbra.search
    - https://github.com/UMNLibraries/umbra_solr_core
- for the `umbra.search` repository: `git checkout podman` 
- ensure that the podman and docker-compose binaries are in your PATH.
    -  `export PATH="/opt/podman/bin:/usr/local/bin:/usr/local/podman/helper/$USER:$PATH"`
- Create a podman VM with `podman machine init --cpus 2 --memory 4096`

#### Linux

- Install Podman per the [Podman Documentation](https://podman.io/docs/installation)
    - Podman Desktop does not actually provide `podman` or `docker-compose` as it does on MacOS, it is however useful for managing images etc.
- clone the relevant repositories if you haven't already
    - https://github.com/UMNLibraries/umbra.search
    - https://github.com/UMNLibraries/umbra_solr_core
- for the `umbra.search` repository: `git checkout podman` 

#### DBus/shell sessions

#### SELinux

- ensure the SELinux stuff is correct on the podman folders in the home directory of the user running it ([https://github.com/containers/podman/issues/11109#issuecomment-891808665](per this GH comment)):
    - `sudo semanage fcontext -ae /var/lib/containers $HOME/.local/share/containers/storage`
    - `sudo restorecon -Rv $HOME/.local/share/containers/storage`

### Building

1. Ensure your environment is correct as per the above
2. _MacOS only_: ensure the podman machine is running with `podman machine start`
3. Change into the `umbra_solr_core` folder and run `./rebuild-podman`
4. Change into the `umbra.search` folder -- double check you are on the `podman` git branch
5. `cp .env-example .env`
6. `mkdir thumbnails`
7. `docker-compose build`
    - _Linux_: if you recive an error `failed to receive status: rpc error...` append `DOCKER_BUILDKIT=0` 
    - _Linux_: ensure that your docker `systemd` services are _disabled_ and that podman user services are running
    - this step may fail, if it does, simply run it again and it should succeed
    - this step will feature many scary depreciation warnings; for the time being, ignore them
8. `docker-compose up`

#### MySQL

1. create the MySQL DB: `docker-compose run web rake db:create && docker-compose run web rake db:migrate && docker-compose run web rake db:seed`
2. navigate to `localhost:3000` in a browser, you should be greeted by a blank umbrasearch web interface
3. in a new tab `localhost:8983/solr/`
4. sidekiq is running at `localhost:3000/sidekiq` if needed

#### Everyone Loves Solr

Once MySQL and the rest of the application is finished with setup as above, setup Solr:

1. initate the OAI harvest: `docker-compose exec web bundle exec rake indexer:dev`
    - this will harvest approximately 600 records (as of 2024-01)
2. commit the records to solr: `docker-compose exec web bundle exec rake solr:commit`
3. build solr suggestions: `docker-compose run web rake solr:suggest_build`
4. backup the solr db: `docker-compose exec web bundle exec rake solr:backup`

Solr's admin page should be running at `localhost:8983/solr/`
 
### Reminders

- you will need to rebuild the containers when you make changes to the application code
- if something blows up that isn't related to changes you've made in code, restarting your podman machine (on MacOS) or restarting podman services might help. The reasons may remain a mystery.
