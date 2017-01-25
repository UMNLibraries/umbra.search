class IndexRecord
  attr_accessor :record
  def initialize(record: {})
    @record = record
  end

  def index!
    Rails.logger.info "Indexing record: #{solr_record['id']}"
    SolrClient.add(solr_record)
  end

  def solr_record
    @solr_record ||= RecordPresenter.new(record).to_solr
  end
end