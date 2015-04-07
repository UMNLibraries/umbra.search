# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :featured_image, :class => 'FeaturedImage' do
    title "Test title"
    record_id "test-record-id"
    published false
    uploaded_image "path/to/upload.png"
  end
end
