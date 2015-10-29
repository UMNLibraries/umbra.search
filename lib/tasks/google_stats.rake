require_relative "setup/setup_helper"

namespace :google_stats do
  include SetupHelper
  desc "Ingest Statistics"
  task :ingest => [:environment] do
    PopulateGoogleAnalyticsFacts.run_monthly!
  end
end
