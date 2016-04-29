require 'rails_helper'
require './app/services/index_from_json_api.rb'

describe IndexFromJsonApi do
  subject { IndexFromJsonApi }

  it "Runs a search and indexes retrieved documents" do
    WebMock.disable_net_connect!
    stub_request(:get, "http://example.com").
      to_return(:status => 200, :body => json_api_response)

   stub_request(:post, "http://127.0.0.1:8889/solr/blacklight-core-umbra/update?wt=ruby").
     to_return(:status => 200, :body => "", :headers => {})

    subject.run!('http://example.com') do |next_url|
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