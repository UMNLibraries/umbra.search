require "#{Rails.root}/lib/tasks/setup/setup_helper.rb"

namespace :solr do
  include SetupHelper
  desc "Download, unpack and run Prodiction Blacklight Jetty"
  task :setup_prod do
    setup_solr('prod', 8983, '4.10.3', 'blacklight-core-umbra', '0.3-alpha')
  end

  desc "Download, unpack and run Development Blacklight Jetty"
  task :setup_dev do
    setup_solr('dev', 8885, '4.10.3', 'blacklight-core-umbra','0.3-alpha')
  end

  desc "Download, unpack and run Test Blacklight Jetty"
  task :setup_test do
    setup_solr('test', 8889, '4.10.3', 'blacklight-core-umbra','0.3-alpha')
  end

  desc "Delete by Query"
  task :delete_by_query, [:query] => [:environment] do |t, args|
    SolrClient.delete_by_query(args[:query].to_s)
  end

  desc "Index Records from JSON API"
  task :index_records,  [:url] => [:environment] do |t, args|
    JsonApiIndexerWorker.perform_async(args[:url])
  end

  desc "Commit Indexed Records"
  task :commit do
    SolrClient.commit
  end
end
