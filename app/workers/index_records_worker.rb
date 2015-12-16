class IndexRecordWorker
  include Sidekiq::Worker
  def perform(start, batch_size)
    solr_docs = []
    Record.find_each(start: start, batch_size: 500) do |record|
      solr_docs << record.solr_doc
    end
    SolrClient.add(solr_docs)
  end
end