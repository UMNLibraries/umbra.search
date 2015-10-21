require 'rails_helper'
require './app/services/google_analytics_client.rb'

describe GoogleAnalyticsQuery do
  let(:credentials) do
    {
      'service_account_email' => ENV['GOOGLE_CLIENT_EMAIL'],
      'key_file'              => ENV['GOOGLE_KEY_FILE'],
      'key_secret'            => ENV['GOOGLE_KEY_SECRET'],
      'profile_id'            => ENV['GOOGLE_PROFILE_ID']
    }
  end
  let(:client) { GoogleAnalyticsClient.client(credentials) }
  let(:ga_query_result) { GoogleAnalyticsQuery.run!(client, credentials['profile_id']) }

  it "runs the default query and gets some results" do
    expect(ga_query_result.data.rows.length).to be > 0
  end
end