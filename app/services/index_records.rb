class IndexRecords
  def self.run!(ingest_name, ingest_hash)
    docs = []
    records = Record.ingest_run(ingest_name, ingest_hash)
    records.each do |record|
      docs <<  record.index_doc
      if docs.length == 500
        SolrClient.add(docs)
        docs = []
      end
    end
    SolrClient.add(docs) if docs.length > 0
  end
end