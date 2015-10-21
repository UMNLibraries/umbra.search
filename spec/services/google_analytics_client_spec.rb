require 'rails_helper'
require './app/services/google_analytics_client.rb'

describe GoogleAnalyticsClient do
  let(:credentials) do
    {
      'service_account_email' => ENV['GOOGLE_CLIENT_EMAIL'],
      'key_file'              => ENV['GOOGLE_KEY_FILE'],
      'key_secret'            => ENV['GOOGLE_KEY_SECRET'],
      'profile_id'            => ENV['GOOGLE_PROFILE_ID']
    }
  end
  let(:client) { GoogleAnalyticsClient.client(credentials) }

  it "connects to googel analytics" do
    expect(client.authorization.scope).to eq ["https://www.googleapis.com/auth/analytics.readonly"]
  end
end