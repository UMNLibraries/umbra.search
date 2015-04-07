require 'rails_helper'

RSpec.describe "featured_images/index", :type => :view do
  before(:each) do
    assign(:featured_images, [
      FactoryGirl.create(:featured_image),
      FactoryGirl.create(:featured_image)
    ])
  end

  it "renders a list of featured_images" do
    render
  end
end
