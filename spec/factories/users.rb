FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password '12345678'

    factory :guest_user do
      guest true
    end

    trait :with_editor_role do
      roles [ 'editor']
    end
  end
end