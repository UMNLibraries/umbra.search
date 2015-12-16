require "#{Rails.root}/lib/tasks/setup/setup_helper.rb"

namespace :flag_vote do
  desc "Index Records"
  task :flag_all do |t, args|
    FlagVote.flag_all!
  end
end
