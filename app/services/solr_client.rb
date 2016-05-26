class SolrClient
  def self.connect
    Blacklight.default_index.connection
  end

  def self.find_record(record_id)
    search("id:#{record_id}")['response']['docs'].first
  end

  def self.add(docs)
    client.add docs
  end

  def self.commit
    client.commit
  end

  # can pass multiple record_ids as an array
  def self.delete(record_id)
    client.delete_by_id record_id
  end

  def self.delete_by_query(query)
    client.delete_by_query "#{query}"
    client.commit
  end

  def self.unescape_json(docs)
    docs.map {|doc| JSON.parse(doc)['record']['originalRecord'] }
  end

  def self.search(query, page: 1, rows: 10, params: {})
    client.paginate page, rows, 'select', :params => {:fl => '*', :q => query}.merge(params)
  end

  def self.client
    SolrClient.connect
  end
end