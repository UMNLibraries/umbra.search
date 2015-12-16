# Modified from https://github.com/google/google-api-ruby-client-samples/blob/1480725b07e7048bc5dc7048606a016c5a8378a7/service_account/analytics.rb
# Inspired by https://gist.github.com/3166610
require 'google/api_client'


class GoogleAnalyticsClient

  # As a convenience, allow api client to store the profile_id for later use
  # with other collaborating objects, like GA queries
  class Google::APIClient
    attr_accessor :profile_id
  end

  def credentials
    {
      'service_account_email' => ENV['GOOGLE_CLIENT_EMAIL'],
      'key_file'              => ENV['GOOGLE_KEY_FILE'],
      'key_secret'            => ENV['GOOGLE_KEY_SECRET'],
      'profile_id'            => ENV['GOOGLE_PROFILE_ID']
    }
  end

  def self.connect
    new.authorize_and_return_client!
  end

  def authorize_and_return_client!
    api = api_client
    api.authorization = get_authorization
    api.authorization.fetch_access_token!
    api.profile_id = credentials['profile_id']
    api
  end

  private

  def api_client
    Google::APIClient.new(:application_name => credentials['application_name'],
                          :application_version => credentials['application_version'])
  end

  def key
    Google::APIClient::KeyUtils.load_from_pkcs12(credentials['key_file'], credentials['key_secret'])
  end

  def get_authorization
    Signet::OAuth2::Client.new(:token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
                               :audience => 'https://accounts.google.com/o/oauth2/token',
                               :scope => 'https://www.googleapis.com/auth/analytics.readonly',
                               :issuer => credentials['service_account_email'],
                               :signing_key => key)
  end
end