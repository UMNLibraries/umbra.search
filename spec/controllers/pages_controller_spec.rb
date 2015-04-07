require 'rails_helper'

describe PagesController, :type => :controller do
  let(:featured_image) { FactoryGirl.create(:featured_image) }
  describe "home" do
    it "selects a random featured image to display in background" do
      expect(controller).to receive(:random_featured_image).and_return("random featured image")
      get :home
      expect(assigns(:featured_image)).to eq("random featured image")
    end
    it "allows you to choose which featured image to display (for previewing)" do
      get :home, featured_image:featured_image.id
      expect(assigns(:featured_image)).to eq(featured_image)
    end
  end
end