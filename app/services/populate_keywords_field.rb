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
    (keywords_ssim + editor_tags).uniq.flatten.compact
  end

  def keywords_ssim
    solr_doc.fetch('keywords_ssim', [])
  end

  def editor_tags
    solr_doc.fetch('editor_tags_ssim', [])
  end
end