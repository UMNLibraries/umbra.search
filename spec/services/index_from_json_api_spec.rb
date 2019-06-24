require 'rails_helper'
require './app/services/index_from_json_api.rb'

describe IndexFromJsonApi do
  it "Runs a search and indexes retrieved documents" do
    WebMock.disable_net_connect!
    stub_request(:get, "http://example.com").
      to_return(:status => 200, :body => json_api_response)

   stub_request(:post, "http://solr_test:8983/solr/cores/update?wt=json").
     to_return(:status => 200, :body => "", :headers => {})

     stub_request(:get, "https://www.umbrasearch.org/flag_votes.json?flags_by_record=true").
     with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'www.umbrasearch.org', 'User-Agent'=>'Ruby'}).
     to_return(:status => 200, :body => "{\"123\": [1]}", :headers => {})

     IndexFromJsonApi.run!('http://example.com') do |next_url|
      expect(next_url).to eq 'http://example.com?page=1'
    end
  end

  def json_api_response
    {
      'data' => [{'id' => 123, 'attributes' => {'metadata' => {'HUBINDEX' => {'title_ssi' => 'foo'}}}}],
      'links' => {'next' => 'http://example.com?page=1'}
    }.to_json
  end
end

WebMock.allow_net_connect!