require 'rails_autolink'
class DocumentPresenter < Blacklight::DocumentPresenter
  include ActionView::Helpers::TextHelper

  ##
  # Render a value (or array of values) from a field
  # use rails_autolink to display links as URLs
  #
  # @param [String] value or list of values to display
  # @param [Blacklight::Solr::Configuration::SolrField] solr field configuration
  # @return [String]
  def render_field_value value=nil, field_config=nil
    safe_values = Array(value).collect { |x| x.respond_to?(:force_encoding) ? auto_link(x.force_encoding("UTF-8"), :link => :urls) : auto_link(x, :link => :urls) }

    if field_config and field_config.itemprop
      safe_values = safe_values.map { |x| content_tag :span, x, :itemprop => field_config.itemprop }
    end

    safe_join(safe_values, (field_config.separator if field_config) || field_value_separator)
  end

  def field_value_separator
    ', '
  end
end