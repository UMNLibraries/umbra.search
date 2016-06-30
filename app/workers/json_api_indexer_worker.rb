class JsonApiIndexerWorker
  include Sidekiq::Worker
  def perform(url)
    IndexFromJsonApi.run!(url) {|next_url|
      JsonApiIndexerWorker.perform_async(next_url) if next_url
    }
  end
end