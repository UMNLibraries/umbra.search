namespace :indexer do
  desc "Pull records from the etl.hub JSON API and ingest them into Solr"
  task :run => [:environment] do
    umbra_records = 'https://lib-metl-prd-01.oit.umn.edu/api/v2/records?filter[all_with_tag]=umbra_index'
    IndexBatchUrls.new(start_url: umbra_records).to_a.map do |url|
      JsonApiIndexerWorker.perform_async(url)
    end
  end
  desc "Index only a small subset of records for development and testing"
  task :devrun => [:environment] do
    umbra_records = 'https://www.umbrasearch.org/catalog.json?f[dataProvider_ssi][]=University+of+Oklahoma+Libraries'
    IndexBatchUrls.new(start_url: umbra_records).to_a.map do |url|
      JsonApiIndexerWorker.perform_async(url)
    end
  end
end
