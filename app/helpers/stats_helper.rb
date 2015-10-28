module StatsHelper


  def data_provider_stats
    stats = []
    DataProvider.all.order(:name).each do |provider|
      stats << {provider_name: provider.name, record_views: StatsQuery.record_views_for_provider(provider.id), origin_clicks: StatsQuery.view_original_clicks_for_provider(provider.id), total: StatsQuery.engagements_for_provider(provider.id)} if provider.name
    end
    stats
  end
end
