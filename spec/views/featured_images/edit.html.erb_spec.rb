require 'rails_helper'

RSpec.describe "featured_images/edit", :type => :view do
  before(:each) do
    @featured_image = assign(:featured_image, FactoryGirl.create(:featured_image))
  end

  it "renders the edit featured_image form" do
    render

    assert_select "form[action=?][method=?]", featured_image_path(@featured_image), "post" do
    end
  end
end
