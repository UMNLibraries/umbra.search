require "#{Rails.root}/lib/tasks/setup/setup_helper.rb"

namespace :solr do
  include SetupHelper
  desc "Download, unpack and run Prodiction Blacklight Jetty"
  task :setup_prod do
    setup_solr('prod', 8983, '4.10.3', 'blacklight-core-umbra', '0.3-alpha')
  end

  desc "Download, unpack and run Development Blacklight Jetty"
  task :setup_dev do
    setup_solr('dev', 8885, '6.3.0', 'blacklight-core-umbra','0.4-alpha')
  end

  desc "Download, unpack and run Test Blacklight Jetty"
  task :setup_test do
    setup_solr('test', 8889, '4.10.3', 'blacklight-core-umbra','0.3-alpha')
  end

  desc "Delete by Query"
  task :delete_by_query, [:query] => [:environment] do |t, args|
    SolrClient.delete_by_query(args[:query].to_s)
  end

  # e.g. bundle exec rake solr:index_records['http://hub-client.lib.umn.edu/api/v2/records?filter[all_with_job_id]=62&page[size]=1000']
  desc "Index Records from JSON API"
  task :index_records,  [:url] => [:environment] do |t, args|
    JsonApiIndexerWorker.perform_async(args[:url])
  end

  desc "Commit Indexed Records"
  task :commit do
    SolrClient.commit
  end

  desc "backup solr data locally"
  task :backup, [:number_to_keep] => :environment  do |t, args|
    keep = args[:number_to_keep].blank? ? 2 : args[:number_to_keep].to_i
    SolrClient.backup(number_to_keep: keep)
  end

  desc "Restore latest backup"
  task restore: [:environment]  do
    SolrClient.restore
  end
end
