class JsonApiIndexerWorker
  include Sidekiq::Worker
  def perform(url)
    IndexFromJsonApi.run!(url)
  end
end