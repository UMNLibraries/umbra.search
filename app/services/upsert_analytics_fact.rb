class UpsertAnalyticsFact
  def self.upsert!(params)
    record_hash = params.fetch(:record_hash)
    metadata = params.fetch(:metadata)
    if metadata
      data_provider = DataProvider.where(name: metadata['dataProvider_ssi']).first_or_create
      record   = Record.where(record_hash: record_hash, data_provider_id: data_provider.id).first_or_create
      category = GoogleAnalyticsCategory.where(name: params.fetch(:category)).first_or_create
      action   = GoogleAnalyticsAction.where(name: params.fetch(:action), google_analytics_category_id: category.id).first_or_create
      location = Location.where(hostname: params.fetch(:hostname), path: params.fetch(:path)).first_or_create
      GoogleAnalyticsFact.where(record_id: record.id, google_analytics_action_id: action.id, location_id: location.id, date: params.fetch(:date), count: params.fetch(:count)).first_or_create
    end
  end
end