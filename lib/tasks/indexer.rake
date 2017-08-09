namespace :indexer do
  include SetupHelper
  desc "Pull records from the etl.hub JSON API and ingest them into Solr"
  task :run => [:environment] do
    JsonApiIndexerWorker.perform_async('http://hub-client.lib.umn.edu/api/v2/records?filter[all_with_tag]=umbramvp')
  end
end
