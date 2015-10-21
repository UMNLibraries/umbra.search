class GoogleAnalyticsQuery
  attr_reader :client, :start_date, :end_date, :profile_id, :api_version

  def self.run!(client, profile_id, start_date = nil, end_date = nil)
    new(client, profile_id, start_date, end_date).query!
  end

  def initialize(client, profile_id, start_date = nil, end_date = nil)
    @client      = client
    @profile_id  = profile_id
    @start_date  ||= '30daysAgo'
    @end_date    ||= 'yesterday'
    @api_version ||= 'v3'
  end

  def analytics_dicsovery_api
    Rails.cache.fetch("google-analytics-api-#{api_version}", expires_in: 12.hours) do
      client.discovered_api('analytics', api_version)
    end
  end

  def query!
      query_data = client.execute(:api_method => analytics_dicsovery_api.data.ga.get, :parameters => {
        'ids' => "ga:" + profile_id,
        'start-date' => start_date,
        'end-date' => end_date,
        'metrics' => 'ga:totalEvents',
        'dimensions' => 'ga:eventCategory,ga:eventAction,ga:eventLabel,ga:date',
        'max-results' => '1000',
        'sort' => '-ga:totalEvents'
      })
    return query_data
  end
end