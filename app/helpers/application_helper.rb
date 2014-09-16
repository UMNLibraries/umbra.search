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
end
