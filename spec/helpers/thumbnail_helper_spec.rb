require 'rails_helper'

describe ThumbnailHelper, :type => :helper do
  let(:thumbnail_url) { "https://www.google.com/images/srpr/logo11w.png?foo=bar" }
  let(:document) {SolrDocument.new( {object_ssi:thumbnail_url, title_ssi:"Awesome Title"})}
  let(:blacklight_config) { CatalogController.new.blacklight_config }
  before(:each) do
    helper.extend Blacklight::Controller
    allow(helper).to receive(:blacklight_config).and_return(blacklight_config)
  end
end