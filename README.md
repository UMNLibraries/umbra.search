Umbra Search
======


This application is an instance of the [Blacklight](https://github.com/projectblacklight/blacklight) Solr discovery interface and will power the forthcoming database search for the [African American Theater History Project](https://www.lib.umn.edu/about/digitalgivens/).

# Developer Quickstart (Docker)

* [Install Docker](https://docs.docker.com/engine/installation)
* [Install Docker Compose](https://docs.docker.com/compose/)
* `$ git clone https://github.com/UMNLibraries/umbra.search.git`
* `$ cd umbra.search`
* `$ cp .env-example .env` 
* `$ mkdir thumbnails`
* `$ docker-compose build`
* `$ docker-compose run web rakd db:migrate`
* `$ docker-compose up`