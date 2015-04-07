require 'rails_helper'

RSpec.describe "pages/home", :type => :view do
  let(:featured_image) { FactoryGirl.create(:featured_image) }

  before(:each) do
    assign(:featured_image, featured_image)
    allow(view).to receive(:search_action_url).and_return("/catalog")
    allow(view).to receive(:blacklight_config).and_return(CatalogController.blacklight_config)
  end

  it "renders the featured image as background and displays its title info" do
    render
    expect(rendered).to have_selector("a#featured","Featured: #{featured_image.title}")
    expect(rendered).to have_content(".home-panel {
        background-image: url(#{featured_image.uploaded_image.url});
      }")
  end
end
