require 'rails_helper'

RSpec.describe "featured_images/show", :type => :view do
  before(:each) do
    @featured_image = assign(:featured_image, FactoryGirl.create(:featured_image))
  end

  it "renders attributes in <p>" do
    render
  end
end
