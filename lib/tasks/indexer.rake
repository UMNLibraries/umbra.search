namespace :indexer do
  desc "Pull records from the etl.hub JSON API and ingest them into Solr"
  task :run => [:environment] do
    umbra_records = 'https://lib-metl-prd-01.oit.umn.edu/api/v2/records?filter[all_with_tag]=umbra_index'
    IndexBatchUrls.new(start_url: umbra_records).to_a.map do |url|
      JsonApiIndexerWorker.perform_async(url)
    end
  end
end
