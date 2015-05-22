class BoardSnapshotWorker
  include Sidekiq::Worker
  def perform(preview_url, file_path)
    Screenshot.snap(preview_url, {
      :output => file_path,
      :top => 0, :left => 3, :width => 200, :height => 150 })
  end
end