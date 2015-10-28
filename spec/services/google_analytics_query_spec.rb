require 'rails_helper'
require './app/services/google_analytics_client.rb'

describe GoogleAnalyticsQuery do
  let(:client) { GoogleAnalyticsClient.connect }
  let(:ga_query_result) { GoogleAnalyticsQuery.run!(client) }

  it "runs the default query and gets some results" do
    expect(ga_query_result.length).to be > 0
  end
end