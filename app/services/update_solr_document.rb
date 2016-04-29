
# Add Service to Modify a Solr Doc
class UpdateSolrDocument
  attr_reader :id

  def initialize(id, solr_client: SolrClient)
    @id = id
  end

  def update
    update_record(yield document)
  end

  private

  def update_record(doc)
    # _version_ = 1 means the document must exist in the index to do this update
    # See: http://yonik.com/solr/optimistic-concurrency
    doc['_version_'] = 1
    solr_client.add [doc]
    solr_client.commit
  end

  def document
    solr_client.find_record(id)
  end

end