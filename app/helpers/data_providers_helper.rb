module DataProvidersHelper
  def data_providers_stats
    stats = []
    DataProvider.all.order(:name).each do |provider|
      stats << {provider_name: provider.name, record_views: StatsQuery.record_views_for_provider(provider.id), origin_clicks: StatsQuery.view_original_clicks_for_provider(provider.id), total: StatsQuery.engagements_for_provider(provider.id)} if provider.name
    end
    stats
  end

  def data_provider_stats(provider_id)
    StatsQuery.facts_for_provider(provider_id)
  end

  def link_to_data_provider_drilldown(name)
    provider = DataProvider.where(name: name).first
    link_to "#{provider.name} (Drill Down)", provider
  end

  def full_record_link(record_id)
    record = Record.find(record_id)
    link_to "#{record.title}", record
  end

  def engagement_name(name)
    labels = {'Record View' => 'Full Record View', 'View Original' => 'View'}
    labels[name]
  end
end
