require 'rails_helper'
require './app/services/google_analytics_client.rb'

describe GoogleAnalyticsClient do
  subject { GoogleAnalyticsClient.connect}

  it "connects to google analytics" do
    expect(subject.authorization.scope).to eq ["https://www.googleapis.com/auth/analytics.readonly"]
  end

  it "stores and provides access to a GA profile_id" do
    expect(subject.profile_id).to eq ENV['GOOGLE_PROFILE_ID']
  end
end