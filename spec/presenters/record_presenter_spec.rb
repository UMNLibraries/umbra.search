require 'rails_helper'
require './app/presenters/record_presenter.rb'

describe RecordPresenter do
  let(:record) { create :record_with_keywords }
  let(:flag) { create :flag }
  let(:flag_vote) { double }
  let(:metadata) { JSON.parse(record.metadata).merge('id' => record.id) }

  before(:all) do
    Rails.cache.clear
  end

  it "encodes a record for ingest into solr" do
   WebMock.disable_net_connect!
   stub_request(:get, "http://solr_test:8983/solr/cores/select?fl=*&q=id:123abc&rows=10&start=0&wt=json").
         to_return(:status => 200, :body => {"response" => {"docs" => [metadata]}}.to_json, :headers => {})
   stub_request(:get, "https://www.umbrasearch.org/flag_votes.json?flags_by_record=true").
     with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'www.umbrasearch.org', 'User-Agent'=>'Ruby'}).
     to_return(:status => 200, :body => "{\"#{record.id}\": [#{flag.id}]}", :headers => {})

    allow(flag_vote).to receive(:flag) { flag }
    allow(flag_vote).to receive(:where) { [flag_vote] }
    presenter = RecordPresenter.new(record, flag_vote: flag_vote)
    expected = metadata.merge({"editor_tags_ssim"=>["Blerb 0", "Blerb 1"], "keywords_ssim"=>["Blerb 0", "Blerb 1", "Civil Rights", "Civil Service", "Civil War"], "flags_isim"=>[flag.id]})
    puts expected.inspect
    expect(presenter.to_solr).to eq expected
  end
end

WebMock.allow_net_connect!