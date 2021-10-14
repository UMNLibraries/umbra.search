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

## Maintenance Tasks
### Refreshing thumbnails (Same as UMedia!)

Thumbnails are stored in S3 (by way of [AWS Lambda and Nailer](https://github.umn.edu/Libraries/nailer)) and served out of CloudFront. The S3 object name is a SHA1 hash of the provider's thumbnail URL as harvested by [ETLHub](https://github.umn.edu/Libraries/etlhub). For example:

**Document**: https://umbrasearch.org/catalog/f220a9e13fa47febee6eb86fe34a4711cf6f79bc
**Has source thumbnail**: https://digitalgallery.bgsu.edu/files/thumbnails/9d24a739eebefe857a6c800694b8a1ae.jpg
**Stored in S3/CloudFront as**: https://d2l9jrtx1kk04i.cloudfront.net/**97ce0e1120fe7962082171af6c12b28881d0274b**.png
**Source thumbnail image sha1**:

```shell
$ echo -n https://digitalgallery.bgsu.edu/files/thumbnails/9d24a739eebefe857a6c800694b8a1ae.jpg | sha1sum
97ce0e1120fe7962082171af6c12b28881d0274b -
```

Thumbnails are stored in S3 and served out of CloudFront. To force a thumbnail
to be refreshed, delete it from the S3 bucket CloudFront is pointing to, then
invalidate the item in CloudFront.

- Examine the image in the browser to find its URL (e.g.
  `https://d2l9jrtx1kk04i.cloudfront.net/97ce0e1120fe7962082171af6c12b28881d0274b.png`)
- Log into AWS console
- Navigate to CloudFront
- Locate the CDN distribution identified by the domain name you found with the
  image (e.g. `d2l9jrtx1kk04i.cloudfront.net`) and note which bucket is its
  `Origin`
- Navigate in the AWS console to S3
- Open the bucket associated with the CloudFront domain and search for the
  thumb's hash (e.g. `97ce0e1120fe7962082171af6c12b28881d0274b`)
- Delete the item from S3
- Navigate in the AWS console to CloudFront
- To force a cache invalidation, open the Distribution, click the
  `Invalidations` tab
- Create a new Invalidation using the thumb's hash as an object path to
  invalidate (`97ce0e1120fe7962082171af6c12b28881d0274b.png`)

### Clearing Rails Cache (if expected display changes do not appear)
The application cache (in Redis) may need to be cleared if collection metadata
changes do not show up after the nightly `rake ingest:collection_metadata` job.

```
$ RAILS_ENV=production bundle exec rails runner 'Rails.cache.clear'
```

----
[UMN deploy and ingest docs](https://github.umn.edu/Libraries/umbra-deploy)
