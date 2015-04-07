require 'rails_helper'

RSpec.describe FeaturedImage, :type => :model do
  subject { FactoryGirl.create(:featured_image) }
  it "has title, record id, publication status and attached image" do
    expect(subject.title).to eq("Test title")
    expect(subject.record_id).to eq("test-record-id")
    expect(subject.published).to be_falsey
    expect(subject.uploaded_image).to be_kind_of FeaturedImageUploader
  end
end
