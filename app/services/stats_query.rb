class StatsQuery

  def self.engagements_for_provider(provider_id)
    GoogleAnalyticsFact.joins(record: :data_provider).where(data_providers: { id: provider_id }).joins(google_analytics_action: :google_analytics_category).sum(:count)
  end

  def self.record_views_for_provider(provider_id)
    summary_query_by_category(provider_id, "Record View")
  end

  def self.view_original_clicks_for_provider(provider_id)
    summary_query_by_category(provider_id, "View Original")
  end

  private 

  def self.summary_query_by_category(provider_id, category)
    GoogleAnalyticsFact.joins(record: :data_provider).where(data_providers: { id: provider_id }).joins(google_analytics_action: :google_analytics_category).where(google_analytics_categories: { name: category }).sum(:count)
  end

end