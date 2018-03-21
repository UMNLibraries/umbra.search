require 'rails_helper'

describe ThumbnailHelper, :type => :helper do
  let(:thumbnail_url) { "https://www.google.com/images/srpr/logo11w.png?foo=bar" }
  let(:document) {SolrDocument.new( {object_ssi:thumbnail_url, title_ssi:"Awesome Title"})}
  let(:blacklight_config) { CatalogController.new.blacklight_config }
  before(:each) do
    helper.extend Blacklight::Controller
    allow(helper).to receive(:blacklight_config).and_return(blacklight_config)
  end
  describe "cached_thumbnail_tag" do
    it "should generate a url for requesting the cached thumb from the ThumbnailsController" do
      rendered_text = helper.cached_thumbnail_tag(document, {})
      rendered_html = Capybara::Node::Simple.new(rendered_text)
      expect( rendered_html ).to have_xpath("//img[@src=\"#{cached_thumb_url(thumbnail_url)}\" and @title='Awesome Title' and @alt='Awesome Title']")
    end
  end
end