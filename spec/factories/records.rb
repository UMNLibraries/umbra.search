# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :record do
    record_hash "MyString"
    ingest_run_hash "MyString"
    ingest_name "MyString"
    metadata "MyText"
  end
end
