class Record < ActiveRecord::Base
  belongs_to :data_provider
  has_many :google_analytics_facts
  has_many :record_tags
  has_many :tags, through: :record_tags
  scope :with_record_hash,   ->(hash)        { where('record_hash = ?', hash) }
  scope :with_ingest_hash,   ->(ingest_hash) { where('ingest_hash = ?', ingest_hash) }
  scope :with_ingest_name,   ->(ingest_name) { where('ingest_name = ?', ingest_name) }
  scope :ingest_run,         ->(ingest_name, ingest_hash) { where('ingest_name = ? AND ingest_hash = ?', ingest_name, ingest_hash) }

  def tag_list
    self.tags.map { |t| t.name }.join(", ")
  end

  def tag_list=(new_value)
    tag_names = new_value.to_s.split(',').map {|tag| tag.strip }
    self.tags = tag_names.map { |name| Tag.find_or_create_by(:name => name) }
  end

  def solr_doc
    @solr_doc ||= SolrClient.find_record(self.record_hash)
  end
end
