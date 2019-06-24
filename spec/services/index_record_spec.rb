require 'rails_helper'
require './app/services/index_record.rb'

describe IndexRecord do
  let(:record) { create :record}
  subject { IndexRecord.new(record: record) }

  it "Indexes just one record" do
    WebMock.disable_net_connect!
    stub_request(:get, "http://solr_test:8983/solr/cores/select?fl=*&q=id:123abc&rows=10&start=0&wt=json").
      to_return(:status => 200, :body => {"response" => {"docs" => [{"foo" => "bar"}]}}.to_json, :headers => {})
    stub_request(:post, "http://solr_test:8983/solr/cores/update?wt=json").
    with(
      body: "[{\"foo\":\"bar\",\"flags_isim\":null}]",
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Content-Type'=>'application/json',
      'User-Agent'=>'Faraday v0.15.4'
      }).
    to_return(status: 200, body: "", headers: {})

    stub_request(:get, "https://www.umbrasearch.org/flag_votes.json?flags_by_record=true").
    with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'www.umbrasearch.org', 'User-Agent'=>'Ruby'}).
    to_return(:status => 200, :body => "{\"123\": [1]}", :headers => {})
    subject.index!

  end
end

WebMock.allow_net_connect!