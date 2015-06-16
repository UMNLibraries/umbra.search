module FacetsHelper
  include Blacklight::FacetsHelperBehavior

  ##
  # Determine if Blacklight should render the display_facet or not
  #
  # By default, only render facets with items.
  #
  # @param [Blacklight::SolrResponse::Facets::FacetField] display_facet
  # @return [Boolean]
  def should_render_facet? display_facet
    # display when show is nil or true
    facet_config = facet_configuration_for_field(display_facet.name)
    # CF - Allow for the restriction of certain facets to certain users
    return false if facet_config.restricted_to_roles && hide_restricted_facet?(facet_config.restricted_to_roles)
    display = should_render_field?(facet_config, display_facet)
    return display && display_facet.items.present?
  end

  ##
  # Look up the label for the facet field
  def facet_field_label field
    label = blacklight_config.facet_fields[field].label
    label = browse_by_label(label) if params[:facet_view] == 'full'
    solr_field_label(
      label,
      :"blacklight.search.fields.facet.#{field}",
      :"blacklight.search.fields.#{field}"
    )
  end

  def browse_by_label(label)
    "Browse By: #{label}"
  end



  ##
  # Standard display of a facet value in a list. Used in both _facets sidebar
  # partial and catalog/facet expanded list. Will output facet value name as
  # a link to add that to your restrictions, with count in parens.
  #
  # @param [Blacklight::SolrResponse::Facets::FacetField]
  # @param [String] facet item
  # @param [Hash] options
  # @option options [Boolean] :suppress_link display the facet, but don't link to it
  # @return [String]
  def render_facet_value(facet_solr_field, item, options ={})
    path = search_action_path(add_facet_params_and_redirect(facet_solr_field, item))
    content_tag(:span, :class => "facet-label") do
      val = facet_display_value(facet_solr_field, item)
      link_to_unless(options[:suppress_link], val, path, :class=>"facet_select #{type_class(val)}")
    end + render_facet_count(item.hits)
  end

  private

  def hide_restricted_facet?(roles)
    return true if current_user.nil?
    return true unless current_user.has_one_of_these_roles?(roles)
    false
  end

  # include values on type fields - we use these to
  def type_class(val)
    case val
    when 'image'
      'icon-picture'
    when 'video'
      'icon-video'
    when 'text'
      'icon-doc-text'
    when 'sound'
      'icon-headphones'
    end
  end
end
