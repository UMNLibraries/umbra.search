require 'rails_helper'

RSpec.describe "featured_images/new", :type => :view do
  before(:each) do
    assign(:featured_image, FeaturedImage.new())
  end

  it "renders new featured_image form" do
    render

    assert_select "form[action=?][method=?]", featured_images_path, "post" do
    end
  end
end
