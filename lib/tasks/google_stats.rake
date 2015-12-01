require "#{Rails.root}/lib/tasks/setup/setup_helper.rb"

namespace :google_stats do
  include SetupHelper
  desc "Ingest Statistics"
  task :ingest => [:environment] do
    PopulateGoogleAnalyticsFacts.run_monthly!
  end
end
