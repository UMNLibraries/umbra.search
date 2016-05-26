class PopulateKeywordsField
  attr_accessor :solr_doc

  def initialize(solr_doc: {})
    @solr_doc = solr_doc
  end

  def keywords
    all_keyword_fields
  end

  private

  def all_keyword_fields
    (subject_field + editor_tags).map { |tag| tag.titleize }.uniq.flatten.compact
  end

  def subject_field
    solr_doc.fetch('subject_ssim', [])
  end

  def editor_tags
    solr_doc.fetch('editor_tags_ssim', [])
  end
end