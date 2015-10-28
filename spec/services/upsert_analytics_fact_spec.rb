require 'rails_helper'
require './app/services/upsert_analytics_fact.rb'

describe GoogleAnalyticsClient do
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
      :record_id => record.id
    }
  end
  subject(:fact) { UpsertAnalyticsFact.upsert!(params) }  

  it "upserts a record when record does not exist" do
    expect(subject.location.hostname).to eq 'localhost'
    expect(subject.location.path).to eq 'foo/bar/123'
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
end