require_relative "setup/setup_helper"

namespace :solr do
  include SetupHelper
  desc "Download, unpack and run Prodiction Blacklight Jetty"
  task :setup_prod do
    setup_solr('prod', 8983, '4.10.3', 'blacklight-core-hub', '0.5-alpha')
  end

  desc "Download, unpack and run Development Blacklight Jetty"
  task :setup_dev do
    setup_solr('dev', 8885, '4.10.3', 'blacklight-core-hub','0.5-alpha')
  end

  desc "Download, unpack and run Test Blacklight Jetty"
  task :setup_test do
    setup_solr('test', 8889, '4.10.3', 'blacklight-core-hub','0.5-alpha')
  end

  desc "Remove non-umbra records"
  task :delete_non_umbra_records => [:environment] do
    SolrClient.delete_by_query("-tags_ssim:umbramvp")
  end

  desc "Delete by Query"
  task :delete_by_query, [:query] => [:environment] do |t, args|
    SolrClient.delete_by_query(args[:query].to_s)
  end

  desc "Index Records"
  task :index_records,  [:ingest_name, :ingest_hash] => [:environment] do |t, args|
    IndexRecords.run!(args[:ingest_name], args[:ingest_hash])
  end
end
