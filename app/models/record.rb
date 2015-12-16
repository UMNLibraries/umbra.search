class Record < ActiveRecord::Base
  belongs_to :data_provider
  has_many :google_analytics_facts
  scope :with_record_hashes, ->(hashes)      { where('record_hash IN (?)', hashes) }
  scope :with_ingest_hash,   ->(ingest_hash) { where('ingest_hash = ?', ingest_hash) }
  scope :with_ingest_name,   ->(ingest_name) { where('ingest_name = ?', ingest_name) }
  scope :ingest_run,         ->(ingest_name, ingest_hash) { where('ingest_name = ? AND ingest_hash = ?', ingest_name, ingest_hash) }

  def title
    solr_metadata['title_ssi']
  end

  def solr_metadata
    SolrClient.find_record(self.record_hash)
  end

  def index_doc
    index_doc = JSON.parse(metadata)['HUBINDEX']
    index_doc['id'] = record_hash
    index_doc['ingest_hash_ssi'] = ingest_hash
    index_doc['ingest_name_ssi'] = ingest_name
    # TODO: get rid of these once DPLA has been restored:
      index_doc['import_job_name_ssi'] = ingest_name
      index_doc['published_bsi']   = true
      index_doc['tags_ssim']       = 'umbramvp'
    #
    index_doc
  end
end