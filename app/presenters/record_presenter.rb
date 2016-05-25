class RecordPresenter < BasePresenter
  presents :record

  attr_accessor :flag_vote
  def initialize(object, template: nil, flag_vote: FlagVote)
    super(object, template: template)
    @flag_vote = flag_vote
  end

  def to_solr
    solr_doc['id']                  = record.record_hash
    solr_doc['import_job_name_ssi'] = record.ingest_name
    solr_doc['editor_tags_ssim']    = normalize tags
    solr_doc['subject_ssim']        = subject_tags
    solr_doc['flags_isim']          = flags(solr_doc['id'])
    solr_doc.delete('_version_')
    solr_doc
  end

  private

  def flags(record_id)
    flag_vote.where(record_id: record_id).map { |fv| fv.flag.id }
  end

  def subject_tags
    normalize subjects + tags
  end

  def normalize(terms)
    terms.sort.uniq.map { |term| term.titleize }
  end

  def subjects
    @subjects ||= solr_doc.fetch('subject_ssim', [])
  end

  def tags
    record.tag_list.split(',').map {|tag| tag.strip }
  end

  def solr_doc
    record.solr_doc
  end
end