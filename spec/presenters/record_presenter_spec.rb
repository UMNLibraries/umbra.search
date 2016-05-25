require 'rails_helper'
require './app/presenters/record_presenter.rb'

describe RecordPresenter do
  let(:record) { create :record, :with_editor_tags }
  let(:flag) { create :flag }
  let(:flag_vote) { double }

  it "encodes a record for ingest into solr" do
    WebMock.disable_net_connect!
   stub_request(:get, "http://127.0.0.1:8889/solr/blacklight-core-umbra/select?fl=*&q=id:123abc&rows=10&start=0&wt=ruby").
         to_return(:status => 200, :body => '{"response" => {"docs" => [{}]}}', :headers => {})
    allow(flag_vote).to receive(:flag) { flag }
    allow(flag_vote).to receive(:where) { [flag_vote] }
    presenter = RecordPresenter.new(record, flag_vote: flag_vote)
    expected = {"id"=>"123abc", "import_job_name_ssi"=>"Fake Provider", "editor_tags_ssim"=>["Blerb 0", "Blerb 1"], "subject_ssim"=>["Blerb 0", "Blerb 1"], "flags_isim"=>[flag.id]}
    expect(presenter.to_solr).to eq expected
  end
end

WebMock.allow_net_connect!