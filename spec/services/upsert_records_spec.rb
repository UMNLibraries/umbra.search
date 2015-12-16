require 'rails_helper'

describe UpsertRecords do
  let(:records) {
    [
      {'record_hash' => '123abc', 'ingest_hash' => 'ingest-run-129', 'ingest_name' => 'Temple', 'metadata' => '[{"foo": "bar"}]'},
      {'record_hash' => '12e21c', 'ingest_hash' => 'ingest-run-129', 'ingest_name' => 'Temple', 'metadata' => '[{"foo": "baz"}]'},
      {'record_hash' => '12dasd', 'ingest_hash' => 'ingest-run-129', 'ingest_name' => 'Temple', 'metadata' => '[{"foo": "baa"}]'}
    ]
  }
  it "creates and updates a batch of records" do
    UpsertRecords.call(records)
    expect(Record.all.length).to eq 3
    expect(Record.where(record_hash: '12dasd').first.metadata).to eq '[{"foo": "baa"}]'
    expect(Record.where(record_hash: '12e21c').first.ingest_hash).to eq 'ingest-run-129'
    expect(Record.where(record_hash: '123abc').first.ingest_name).to eq 'Temple'
    UpsertRecords.call([{'record_hash' => '123abc', 'ingest_hash' => 'ingest-run-129', 'ingest_name' => 'Templez', 'metadata' => '[{"foo": "bar"}]'}])
    expect(Record.where(record_hash: '123abc').first.ingest_name).to eq 'Templez'
  end
end