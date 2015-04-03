require_relative "setup/setup_helper"

namespace :setup_solr do
  include SetupHelper
  desc "Download, unpack and run Prodiction Blacklight Jetty"
  task :prod do
    setup_solr('prod', 8983, '4.10.3', 'blacklight-core-hub', '0.3-alpha')
  end

  desc "Download, unpack and run Development Blacklight Jetty"
  task :dev do
    setup_solr('dev', 8885, '4.10.3', 'blacklight-core-hub','0.3-alpha')
  end

  desc "Download, unpack and run Test Blacklight Jetty"
  task :test do
    setup_solr('test', 8889, '4.10.3', 'blacklight-core-hub','0.3-alpha')
  end
end
