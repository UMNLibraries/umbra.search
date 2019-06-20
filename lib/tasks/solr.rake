namespace :solr do
  desc "Delete by Query"
  task :delete_by_query, [:query] => [:environment] do |t, args|
    SolrClient.delete_by_query(args[:query].to_s)
  end

  # e.g. bundle exec rake solr:index_records['http://hub-client.lib.umn.edu/api/v2/records?filter[all_with_job_id]=62&page[size]=1000']
  desc "Index Records from JSON API"
  task :index_records,  [:url] => [:environment] do |t, args|
    IndexBatchUrls.new(start_url: args[:url]).to_a.map do |url|
      JsonApiIndexerWorker.perform_async(url)
    end
  end

  desc "Commit Indexed Records"
  task commit: [:environment] do
    SolrClient.commit
  end

  desc "Commit Indexed Records"
  task optimize: [:environment] do
    SolrClient.optimize
  end

  desc "backup solr data locally"
  task :backup, [:number_to_keep] => :environment do |t, args|
    keep = args[:number_to_keep].blank? ? 2 : args[:number_to_keep].to_i
    SolrClient.backup(number_to_keep: keep)
  end

  desc "Restore latest backup"
  task restore:  [:environment] do
    SolrClient.restore
  end
end
