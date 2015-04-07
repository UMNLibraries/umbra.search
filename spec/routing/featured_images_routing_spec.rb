require "rails_helper"

RSpec.describe FeaturedImagesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/featured_images").to route_to("featured_images#index")
    end

    it "routes to #new" do
      expect(:get => "/featured_images/new").to route_to("featured_images#new")
    end

    it "routes to #show" do
      expect(:get => "/featured_images/1").to route_to("featured_images#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/featured_images/1/edit").to route_to("featured_images#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/featured_images").to route_to("featured_images#create")
    end

    it "routes to #update" do
      expect(:put => "/featured_images/1").to route_to("featured_images#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/featured_images/1").to route_to("featured_images#destroy", :id => "1")
    end

  end
end
