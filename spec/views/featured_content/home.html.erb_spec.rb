require 'rails_helper'

RSpec.describe "pages/home", :type => :view do
  let(:featured_content) { create :featured_content, :published }

  before(:each) do
    allow(view).to receive(:search_action_url).and_return("/catalog")
    allow(view).to receive(:blacklight_config).and_return(CatalogController.blacklight_config)
  end

  it "renders a published featured content but not an unpublished on" do
    create :featured_content, :unpublished
    create :featured_content, :published
    @featured_contents = FeaturedContent.published
    render
    expect(rendered).to have_selector(".featured-content .title", featured_content.title)
    expect(rendered).to have_content("Featured Collections")
    expect(rendered).not_to have_content("This item is unpublished")
  end
end
