require 'rails_helper'

describe ThumbnailHelper, :type => :helper do
  let(:thumbnail_url) { "http://my.url.com/item1" }
  let(:document) {SolrDocument.new( {object_s:thumbnail_url})}
  let(:blacklight_config) { CatalogController.new.blacklight_config }
  before(:each) do
    helper.extend Blacklight::Controller
    allow(helper).to receive(:blacklight_config).and_return(blacklight_config)
  end
  describe "cached_thumbnail_tag" do
    it "should rely on FileCache to return the best url" do
      cache_url = "http://best.thumb.com/url.jpg"
      expect(FileCache).to receive(:lookup).with(thumbnail_url).and_return(cache_url)
      rendered_text = helper.cached_thumbnail_tag(document, {})
      rendered_html = Capybara::Node::Simple.new(rendered_text)
      expect( rendered_html ).to have_xpath("//img[@src=\"#{cache_url}\"]")
    end
  end
end