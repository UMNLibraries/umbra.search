namespace :flag_vote do
  desc "Index Records"
  task :flag_all => [ :environment ] do |t, args|
    FlagVote.flag_all!
  end
end
