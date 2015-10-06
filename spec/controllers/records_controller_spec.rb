require 'rails_helper'

describe RecordsController, type: :controller do
  let(:api_key) { create :api_key }
  let(:records) {
    [
      {'record_hash' => '123abc', 'ingest_hash' => 'ingest-run-129', 'ingest_name' => 'Temple', 'metadata' => '[{"foo": "bar"}]'},
      {'record_hash' => '12e21c', 'ingest_hash' => 'ingest-run-129', 'ingest_name' => 'Temple', 'metadata' => '[{"foo": "baz"}]'},
      {'record_hash' => '12dasd', 'ingest_hash' => 'ingest-run-129', 'ingest_name' => 'Temple', 'metadata' => '[{"foo": "baa"}]'}
    ]
  }

  describe "POST upsert (JSON)" do
    it "adds a record and returns success" do
      post :upsert, {'api_key' => api_key.access_token, 'records' => records }
      expect(response).to have_http_status(:success)
      record = Record.where(:record_hash => '123abc').take
      expect(record.metadata).to eq '[{"foo": "bar"}]'
    end
  end

end
