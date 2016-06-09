require 'digest/sha1'

FakeRecord = Struct.new("FakeRecord", :record_hash, :ingest_name, :tag_list) do
  def solr_doc
    {}
  end
end

class IndexFromJsonApi
  def self.run!(url)
    results = response(url)
    SolrClient.add(results['data'].map { |result| json_api_to_solr(result) })
    Rails.logger.info "Ingesting another batch of #{results['data'].length} solr docs from query: #{url}"
    yield results['links'].fetch('next', false) if block_given?
  end

  def self.response(url)
    JSON.parse(fetch_url(url))
  end

  def self.json_api_to_solr(result)
    attrs = result['attributes']
    doc   =  enrich_doc_with_local_record(attrs['metadata']['HUBINDEX'])
    doc.merge({'id' => attrs['record-hash'],
               'import_job_name_ssi' => attrs['import-job-name'],
               'tags_ssim' => attrs['import-job-tags']})
  end

  def self.enrich_doc_with_local_record(doc)
    RecordPresenter.new(local_record(doc['id'])).to_solr.merge(doc)
  end

  def self.local_record(id)
    Record.with_record_hash(id).first || fake_record
  end

  def self.fake_record
    FakeRecord.new('fake_hash', 'fake_ingest', '')
  end

  def self.fetch_url(url)
      raise "Must Provide a URL to fetch remote data" if !url
      start_time = Time.now
      data = open(url, :read_timeout => 601) { |http| http.read  }
    rescue Exception => error
      elapsed = Time.now - start_time
      raise "Request Failed for #{url} with error #{error} and elapsed time of #{elapsed}"
  end
end