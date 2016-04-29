require 'rails_helper'
require './app/services/index_all_records.rb'

describe IndexAllRecords do
  let(:record) { create :record}
  subject { IndexAllRecords.new }

  it "Indexes all available records" do
    WebMock.disable_net_connect!
     record = create :record

    stub_request(:get, "http://127.0.0.1:8889/solr/blacklight-core-umbra/select?fl=*&q=id:123abc&rows=10&start=0&wt=ruby").
      to_return(:status => 200, :body => '{"response" => {"docs" => [{"foo" => "bar"}]}}', :headers => {})
    stub_request(:post, "http://127.0.0.1:8889/solr/blacklight-core-umbra/update?wt=ruby").
      with(:body => "<?xml version=\"1.0\" encoding=\"UTF-8\"?><add><doc><field name=\"foo\">bar</field><field name=\"id\">123abc</field><field name=\"import_job_name_ssi\">Fake Provider</field><field name=\"tags_ssim\">umbramvp</field></doc></add>",
          :headers => {'Content-Type'=>'text/xml'})

    subject.index!

    expect(WebMock).to have_requested(:post, "http://127.0.0.1:8889/solr/blacklight-core-umbra/update?wt=ruby").
      with(:body => "<?xml version=\"1.0\" encoding=\"UTF-8\"?><add><doc><field name=\"foo\">bar</field><field name=\"id\">123abc</field><field name=\"import_job_name_ssi\">Fake Provider</field><field name=\"tags_ssim\">umbramvp</field></doc></add>",
       :headers => {'Content-Type'=>'text/xml'})
  end
end

WebMock.allow_net_connect!