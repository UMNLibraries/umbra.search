namespace :google_stats do
  desc "Ingest Statistics"
  task :ingest => [:environment] do
    PopulateGoogleAnalyticsFacts.run_monthly!
  end
end
