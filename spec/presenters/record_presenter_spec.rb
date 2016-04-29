require 'rails_helper'
require './app/presenters/record_presenter.rb'

describe RecordPresenter do
  let(:record) { create :record, :with_editor_tags }
  subject { RecordPresenter.new(record) }

  it "encodes a record for ingest into solr" do
    WebMock.disable_net_connect!
    stub_request(:get, "http://127.0.0.1:8889/solr/blacklight-core-umbra/select?fl=*&q=id:123abc&rows=10&start=0&wt=ruby").
     to_return(:status => 200, :body => '{"response" => {"docs" => [{"foo" => "bar"}]}}', :headers => {})
    expected = {"editor_tags_ssim" => ["blerb 0", "blerb 1"], "foo" => "bar", "id" => "123abc", "import_job_name_ssi" => "Fake Provider", "subjects_tags_ssim" => ["blerb 0", "blerb 1"], "tags_ssim" => "umbramvp"}
    expect(subject.to_solr).to eq expected
  end

end