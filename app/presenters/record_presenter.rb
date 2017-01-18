class RecordPresenter < BasePresenter
  presents :record

  attr_accessor :flag_vote, :solr_doc
  def initialize(object, template: nil, flag_vote: FlagVote)
    super(object, template: template)
    @flag_vote = flag_vote
  end

  def to_solr(doc: {})
    @solr_doc = (doc.length > 0) ? doc : solr_doc
    solr_doc['editor_tags_ssim']  = normalize tags
    solr_doc['keywords_ssim']     = keywords
    solr_doc['flags_isim']        = flags(solr_doc['id'])
    solr_doc.delete('_version_')
    solr_doc
  end

  private

  def flags(record_id)
    Rails.cache.fetch("flags_by_record", expires_in: 1.hour) do
      JSON.parse(Net::HTTP.get(uri))[record_id.to_s]
    end
  end

  # Flags are gathered exclusively from the production isntance
  # This allows us to index in dev and swap that index into prod
  def uri
    @uri ||= URI.parse('https://www.umbrasearch.org/flag_votes.json?flags_by_record=true')
  end

  def keywords
    (normalize subjects + tags).uniq.sort
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
    @solr_doc ||= record.solr_doc
  end
end