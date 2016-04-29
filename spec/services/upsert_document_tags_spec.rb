require 'rails_helper'

describe UpsertDocumentTags do
  let(:tags) { ['foo', 'bar', 'baz'] }
  it "adds new tags and associates them with a document" do
    UpsertDocumentTags.new(tags: tags, document_id: 1).replace_tags!
    expect(DocumentTag.all.length).to eq 3
  end
end