Umbra Search
======


This application is an instance of the [Blacklight](https://github.com/projectblacklight/blacklight) Solr discovery interface and will power the forthcoming database search for the [African American Theater History Project](https://www.lib.umn.edu/about/digitalgivens/).

# Developer Quickstart (Docker)

* [Install Docker](https://docs.docker.com/engine/installation)
* [Install Docker Compose](https://docs.docker.com/compose/)

```shell
# Clone main project repository
$ git clone https://github.com/UMNLibraries/umbra.search.git

# Clone related Solr core repository into
# used by docker-compose
$ git clone git@github.com:UMNLibraries/umbra_solr_core.git

# Build docker image
$ cd umbra_solr_core && ./rebuild.sh

# Return to the umbra source dir to complete setup
$ cd /path/to/umbra.search


$ cp .env-example .env
$ mkdir thumbnails

# Build & start services
$ docker-compose build
$ docker-compose up

# Create database (if not already existing in docker volume)
$ docker-compose run web rake db:create

# Run migrations and load seed
$ docker-compose run web rake db:migrate
$ docker-compose run web rake db:seed
```

**Note:** You must rebuild the app's Docker image after any updates to the
`Gemfile`. Doing a local `bundle update` will NOT affect Docker, and you may
still be missing gems resulting in confusing errors from docker-compose when you
believe you do have the necessary gems.

```
app_1          | Could not find rake-13.0.2 in any of the sources
app_1          | Run `bundle install` to install missing gems.
```

Resolve with a new `docker-compose build` and restart the containers.

### Run Rspec tests
```shell
# Ensure test database has been created
$ docker-compose run -e "RAILS_ENV=test" web rake db:create
$ docker-compose run -e "RAILS_ENV=test" web rake db:migrate

# Run rspec
$ docker-compose exec -e "RAILS_ENV=test" web rake spec
```

### Connect to the database
```shell
$ docker-compose exec db mysql -ppassword umbra
```

----
[UMN deploy and ingest docs](https://github.umn.edu/Libraries/umbra-deploy)
