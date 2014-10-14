class FileCachePopulatorWorker
  include Sidekiq::Worker

  def perform(url)
    FileCache.store(url)
  end
end