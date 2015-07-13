# -*- encoding : utf-8 -*-
class SolrDocument 
  include Blacklight::Solr::Document

  def self.bag_of_words(document)
    "#{document.fetch('sourceResource_description_tesi', '')} #{document['title_ssi']} #{document.fetch('subject_ssim', []).join(' ')} #{document.fetch('creator_ssim', []).join(' ')}".gsub(/[^a-z0-9\s]/i, '').gsub(/\n{1,}|\t{1,}/i, ' ').gsub(/\s{1,}/i, ' ')
  end
  # self.unique_key = 'id'
  
  # Email uses the semantic field mappings below to generate the body of an email.
  SolrDocument.use_extension( Blacklight::Document::Email )
  
  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  SolrDocument.use_extension( Blacklight::Document::Sms )

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Solr::Document::ExtendableClassMethods#field_semantics
  # and Blacklight::Solr::Document#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension( Blacklight::Document::DublinCore)

end
