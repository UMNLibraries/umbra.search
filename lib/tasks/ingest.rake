require "#{Rails.root}/lib/tasks/setup/setup_helper.rb"

namespace :ingest do
  include SetupHelper
  desc "Ingest records from directories records"
  task :records, [:directory_path, :ingest_hash, :ingest_name, :batch_size] => [ :environment ] do |t, args|
    Aurora::Ingester.new(args.to_h).run!
  end
end
