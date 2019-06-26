module ApplicationHelper

  ##
  # Get the tagline of this application, from either:
  #  - the Rails configuration
  #  - an i18n string (key: blacklight.application_name; preferred)
  #
  # @return [String] the tagline for this application
  def tagline
    return Rails.application.config.tagline if Rails.application.config.respond_to? :tagline
    t('blacklight.tagline')
  end

 def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def record_count
    Rails.cache.fetch("record_count", expires_in: 1.day) do
      solr = Blacklight.default_index.connection
      num_found = solr.get('select', :params => {:q => '*:*', :fl => '', :rows => 1, :fq => '-flags_isim:[* TO *]'})["response"]["numFound"]
      number_with_delimiter(num_found, :delimiter => ',')
    end
  end
end
