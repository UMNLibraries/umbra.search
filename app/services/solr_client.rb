class SolrClient
  def self.connect
    Blacklight.default_index.connection
  end

  def self.find_record(record_id)
    get_docs("id:#{record_id}")['response']['docs'].first
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

  def self.extract_records(query)
    rows_per_request = 1000
    pages = numfound(query) / rows_per_request
    (0..pages).each do |page|
      start = page * rows_per_request
      puts "SolrClient.extract_records(query): processing start #{start}"
      yield start, extract_metadata(get_docs(query, start, rows_per_request)['response']['docs'])
    end
  end

  def self.export(query, export_dir = nil, file_prefix = nil)
    export_dir  ||= "#{Rails.root}/tmp/solr"
    file_prefix ||= 'solr_export'
    Dir.mkdir(export_dir) if !Dir.exist?(export_dir) 
    extract_records(query) do |start, docs|  
      File.open("#{export_dir}/#{file_prefix}-#{start}.json", "w") {|file| file.write({'records' => unescape_json(docs)}.to_json) } 
    end
  end

  def self.unescape_json(docs)
    docs.map {|doc| JSON.parse(doc)['record']['originalRecord'] }
  end

  def self.numfound(query)
    get_docs(query)['response']['numFound']
  end

  def self.extract_metadata(docs)
    docs.map {|doc| doc['metadata_tesi']}
  end

  def self.get_docs(query, start = nil, rows = nil)
    start ||= 0
    rows ||= 10
    client.get 'select', :params => {:fl => '*', :q => query, :start => start, :rows => rows}
  end

  def self.client
    SolrClient.connect
  end
end