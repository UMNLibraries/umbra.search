class StatsQuery

  def self.engagements_for_provider(provider_id)
    Rails.cache.fetch("google_facts-provider-total-#{provider_id}", expires_in: 12.hours) do
      GoogleAnalyticsFact.joins(record: :data_provider).where(data_providers: { id: provider_id }).joins(google_analytics_action: :google_analytics_category).sum(:count)
    end
  end

  def self.facts_for_provider(provider_id)
    Rails.cache.fetch("google_facts-provider-#{provider_id}", expires_in: 12.hours) do
      GoogleAnalyticsFact.select("SUM(count) as count, record_id, google_analytics_categories.name as category_name").joins(record: :data_provider).where(data_providers: { id: provider_id }).joins(google_analytics_action: :google_analytics_category).group(:google_analytics_action_id, :record_id)
    end
  end

  def self.record_views_for_provider(provider_id)
    summary_query_by_category(provider_id, "Record View")
  end

  def self.view_original_clicks_for_provider(provider_id)
    summary_query_by_category(provider_id, "View Original")
  end

  private 

  def self.summary_query_by_category(provider_id, category)
    Rails.cache.fetch("google_facts-category#{provider_id}-#{category}", expires_in: 12.hours) do
      GoogleAnalyticsFact.joins(record: :data_provider).where(data_providers: { id: provider_id }).joins(google_analytics_action: :google_analytics_category).where(google_analytics_categories: { name: category }).sum(:count)
    end
  end

end