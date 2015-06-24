class SolrClient
  def self.connect
    Blacklight.default_index.connection
  end

  def self.find_record(record_id)
    response = client.get 'select', :params => {:q => "id:#{record_id}"}
    response['response']['docs'].first
  end

  def self.add(docs)
    client.add docs
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

  def self.client
    SolrClient.connect
  end
end