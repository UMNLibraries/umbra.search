require 'digest/sha1'

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
    doc   = attrs['metadata']['HUBINDEX']
    doc.merge({'id' => attrs['record-hash'],
               'import_job_name_ssi' => attrs['import-job-name'],
               'tags_ssim' => attrs['import-job-tags']})
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