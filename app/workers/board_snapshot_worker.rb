class BoardSnapshotWorker
  include Sidekiq::Worker
  def perform(preview_url, seconds_to_expiration)
    Umbra::FeaturedBoards::Snapshot.new(preview_url, seconds_to_expiration).take!
  end
end