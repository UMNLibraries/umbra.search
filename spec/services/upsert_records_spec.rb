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
    expect(Record.find('12dasd').metadata).to eq '[{"foo": "baa"}]'
    expect(Record.find('12e21c').ingest_hash).to eq 'ingest-run-129'
    expect(Record.find('123abc').ingest_name).to eq 'Temple'
    UpsertRecords.call([{'record_hash' => '123abc', 'ingest_hash' => 'ingest-run-129', 'ingest_name' => 'Templez', 'metadata' => '[{"foo": "bar"}]'}])
    expect(Record.find('123abc').ingest_name).to eq 'Templez'
  end
end