namespace :indexer do
  desc "Pull records from the etl.hub JSON API and ingest them into Solr"
  task :run => [:environment] do
    JsonApiIndexerWorker.perform_async('https://lib-metl-prd-01.oit.umn.edu/api/v2/records?filter[all_with_tag]=umbra_index')
  end
end
