require 'rails_helper'

describe FeaturedImagesHelper, :type => :helper do
  let(:featured_image) { FactoryGirl.build(:featured_image) }
  describe "published_status" do
    it "returns a styled div containing the publication status of the featured_image" do
      featured_image.published = false
      expect(helper.published_status(featured_image)).to have_selector("div.text-warning", "Not published")
      featured_image.published = true
      expect(helper.published_status(featured_image)).to have_selector("div.text-success", "Published")
    end
  end

  describe "featured_image_preview_path" do
    it "returns the path to use for previewing the Umbra homepage with the given featured_image" do
      featured_image.id = 22
      expect(helper.featured_image_preview_path(featured_image)).to eq('/?featured_image=22')
    end
  end

  describe "link_to_featured_record" do
    it "returns a link to the record with the given record_id" do
      puts helper.link_to_featured_record("a-record-id")
      expect(helper.link_to_featured_record("a-record-id")).to have_link("a-record-id","/catalog/a-record-id")
    end
    it "lets you set the link text" do
      expect(helper.link_to_featured_record("a-record-id", "My link!")).to have_link("My link!", "/catalog/a-record-id")
    end
    it "displays a message if the record id is missing or empty" do
      expect(helper.link_to_featured_record(nil)).to have_selector("span.text-danger","Unspecified")
    end
  end

  describe "random_featured_image" do
    it "returns a FeaturedImage selected randomly from the current _published_ FeaturedImage objects" do
      featured_image.published = true
      featured_image.save
      returned_image = helper.random_featured_image
      expect(returned_image).to be_instance_of(FeaturedImage)
      expect(returned_image.published).to be_truthy
    end
  end
end