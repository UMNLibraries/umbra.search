require_relative "setup/setup_helper"

namespace :jetty_setup do
  include SetupHelper
  desc "Download, unpack and run Blacklight Jetty"
  task :prod do
    setup_jetty('test', 8983, '4.6.0', '0.1-alpha')
  end

  task :dev do
    setup_jetty('test', 8889, '4.6.0', '0.1-alpha')
  end

  task :test do
    setup_jetty('test', 8888, '4.6.0', '0.1-alpha')
  end
end
