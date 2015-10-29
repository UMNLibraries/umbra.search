class UpsertAnalyticsFact
  def self.upsert!(params)
    record_hash = params.fetch(:record_hash)
    metadata = params.fetch(:metadata)
    if metadata
      data_provider = DataProvider.find_or_create_by(name: metadata['dataProvider_ssi'])
      record   = Record.find_or_create_by(record_hash: record_hash, data_provider_id: data_provider.id)
      category = GoogleAnalyticsCategory.find_or_create_by(name: params.fetch(:category))
      action   = GoogleAnalyticsAction.find_or_create_by(name: params.fetch(:action), google_analytics_category_id: category.id)
      location = Location.find_or_create_by(hostname: params.fetch(:hostname), path: params.fetch(:path))
      GoogleAnalyticsFact.find_or_create_by(record_id: record.id, google_analytics_action_id: action.id, location_id: location.id, date: params.fetch(:date), count: params.fetch(:count))
    end
  end
end