class PopulateAllKeywords
  attr_reader :page, :rows

  def initialize(page: 1, rows: 1000)
    puts "Indexing page: #{page}"
    @page = page
    @rows = rows
  end

  def run!
    index_docs!
    PopulateAllKeywords.new(page: page + 1, rows: rows).run! unless last_page?
  end

  def last_page?
    docs.length == 0
  end

  def index_docs!
    SolrClient.add(docs_with_keywords)
    SolrClient.commit
  end

  def docs_with_keywords
    docs.map do |doc|
      doc['keywords_ssim'] = PopulateKeywordsField.new(solr_doc: doc).keywords
      doc['_version_'] = 1
      doc
    end
  end

  def docs
    @docs = response.fetch('docs')
  end

  def response
    @response ||= SolrClient.search('*:*', page: page, rows: rows)['response']
  end

end