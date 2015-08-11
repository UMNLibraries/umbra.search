# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :featured_content do
    title "This content is featured"
    preview_image "example.jpg"
  end

  trait :unpublished do
    title "This item is unpublished"
    published false
  end

  trait :published do
    published true
  end
end
