require 'rails_helper'

describe CatalogHelper, :type => :helper do
  let(:blacklight_config) { CatalogController.new.blacklight_config }
  before(:each) do
    helper.extend Blacklight::Controller
    allow(helper).to receive(:blacklight_config).and_return(blacklight_config)
  end
  it "should use custom thumbnail method" do
    # Note: this is partially testing that config.index.thumbnail_method is set in Controller blacklight_config
    subject.extend ThumbnailHelper
    expect(helper).to receive(:cached_thumbnail_tag).and_return(nil)
    helper.render_thumbnail_tag(SolrDocument.new( {object_s:"http://my.url.com"}))
  end
end
