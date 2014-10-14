require 'rails_helper'

describe CatalogController, :type => :controller do
  it "should be configured to use custom thumbnail method" do
    # this is testing that the controller is configured to use the custom method
    expect( subject.blacklight_config.view_config(:index).thumbnail_method ).to eq(:cached_thumbnail_tag)
    expect( subject.blacklight_config.view_config(:show).thumbnail_method ).to eq(:cached_thumbnail_tag)
  end
end