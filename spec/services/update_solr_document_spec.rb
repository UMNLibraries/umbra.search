require 'rails_helper'
require './app/services/update_solr_document.rb'

describe UpdateSolrDocument do
  let(:record) { create :record }
  let(:params) do
    {
      :category  => 'Original Record',
      :action    => 'List Search Result',
      :label     => '234234|localhost|foo/bar',
      :hostname  => 'localhost',
      :path      => 'foo/bar/123',
      :date      => '20151017',
      :count     => '3',
      :record_hash => '23234sfdjk23j12',
      :metadata => {'dataProvider_ssi' => 'U State'}
    }
  end
  subject(:fact) { UpsertAnalyticsFact.upsert!(params) }  

  it "upserts a record when record does not exist" do
    expect(subject.record.record_hash).to eq params[:record_hash]
  end
  
  it "upserts a location when location does not exist" do
    expect(subject.location.hostname).to eq 'localhost'
    expect(subject.location.path).to eq 'foo/bar/123'
  end

  it "upserts an analytics category when category does not exist" do
    expect(subject.google_analytics_action.google_analytics_category.name).to eq 'Original Record'
  end

  it "upserts an analytics action when action does not exist" do
    expect(subject.google_analytics_action.name).to eq 'List Search Result'
  end

  it "creates a data provider" do
    expect(subject.record.data_provider.name).to eq 'U State'
  end
end