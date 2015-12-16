# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    title "MyString"
    body "MyText"
    link_title "MyString"
    link_path "MyString"
  end
end
