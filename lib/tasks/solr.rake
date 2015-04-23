require_relative "setup/setup_helper"

namespace :solr do
  include SetupHelper
  desc "Download, unpack and run Prodiction Blacklight Jetty"
  task :setup_prod do
    setup_solr('prod', 8983, '4.10.3', 'blacklight-core-hub', '0.4-alpha')
  end

  desc "Download, unpack and run Development Blacklight Jetty"
  task :setup_dev do
    setup_solr('dev', 8885, '4.10.3', 'blacklight-core-hub','0.4-alpha')
  end

  desc "Download, unpack and run Test Blacklight Jetty"
  task :setup_test do
    setup_solr('test', 8889, '4.10.3', 'blacklight-core-hub','0.4-alpha')
  end

  desc "Remove non-umbra records"
  task :delete_non_umbra_records => [ :environment ] do
    SolrClient.delete_by_query("-tags_ssim:umbramvp")
  end
end
