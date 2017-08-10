namespace :thumbails do
  include SetupHelper
  desc "Truncates thumbnail file registry table to trigger fresh downloads"
  task :wipe => [:environment] do
    ActiveRecord::Base.connection.execute('truncate file_caches')
  end
end
