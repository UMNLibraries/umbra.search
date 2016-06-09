# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :record do
    record_hash "123abc"
    ingest_hash "1.0"
    ingest_name "Fake Provider"
    metadata '{"title": "Berb here"}'

    trait :with_editor_tags do
      before(:create) do |record|
        (0..1).map { |delta| record.record_tags << FactoryGirl.build(:record_tag, tag: FactoryGirl.build(:tag, name: "blerb #{delta}"), record: record) }
      end
    end

    trait :with_metadata_with_subjects do
      metadata '{"subject_ssim": ["Civil War", "Civil Rights", "Civil Service"]}'
    end

    factory :record_with_keywords, :traits => [:with_editor_tags, :with_metadata_with_subjects]
  end

end
