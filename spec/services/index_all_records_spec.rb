require 'rails_helper'
require './app/services/index_all_records.rb'

describe IndexAllRecords do
  let(:record) { create :record}
  let(:indexer_klass) { double }
  let(:indexer_klass_obj) { double }
  subject { IndexAllRecords.new(indexer_klass: indexer_klass) }

  it "Indexes all available records" do
    expect(indexer_klass).to receive(:new).with(record: record) { indexer_klass_obj }
    expect(indexer_klass_obj).to receive(:index!)
    subject.index!
  end
end