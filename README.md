Umbra
======

### Status
[![Build Status](https://travis-ci.org/UMNLibraries/umbra.search.svg)](https://travis-ci.org/UMNLibraries/aath.search)

This application is an instance of the [Blacklight](https://github.com/projectblacklight/blacklight) Solr discovery interface and will power the forthcoming database search for the [African American Theater History Project](https://www.lib.umn.edu/about/digitalgivens/).

# Developer Quickstart (Docker)

* [Install Docker](https://docs.docker.com/engine/installation)
* [Install Docker Group](https://docs.docker.com/engine/installation/linux/ubuntulinux/#/create-a-docker-group)
* [Install Docker Compose](https://docs.docker.com/compose/)
* `$ git clone https://github.com/UMNLibraries/umbra.search.git`
* `$ cd umbra.search`
* `$ mkdir thumbnails`
* `$ docker-compose run solr_setup`
* `$ docker-compose build web`
* `$ docker-compose up`

Open another tab in your terminal and enter:

* `$ docker-compose run web rake db:migrate`

### Set environment variables

```bash
export SECRET_KEY_BASE_AATH_SEARCH=32e34f7607cf620e214c83159ef1322b78be6d1ea98879e7a0a40458e54b75632a5d14ec7814eb09f83b98444f78e4790ed863c2fc0c99d55760e09f2d52bf40
export AATH_SEARCH_DB_USERNAME=umbra
export AATH_SEARCH_DB_NAME=aath_search_development
export AATH_SEARCH_TEST_DB_NAME=aath_search_test
```

### To start server
`rails s`

### To start workers
`bundle exec sidekiq -C config/sidekiq.yml`
