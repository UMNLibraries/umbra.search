require 'rails_autolink'
module Umbra
  class DocumentPresenter < Blacklight::DocumentPresenter
  include ActionView::Helpers::TextHelper
    attr_reader :document

    def record
      Record.find_by(record_hash: id) || Record.new(record_hash: id)
    end

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

    def has_sound_without_image?
      type == 'sound' && img == nil
    end

    def id
      document.fetch('id')
    end

    def img
      document.fetch('object_ssi', false).to_s
    end

    def thumb_url
      document.fetch('isShownAt_ssi', false)
    end

    def has_keywords?
      !keywords.empty?
    end

    def keywords
      document.fetch('keywords_ssim', [])
    end

    def subjects
      document.fetch('keywords_ssim', false)
    end

    def rights
      document.fetch('sourceResource_rights_ssi', false)
    end

    def data_provider
      document.fetch('dataProvider_ssi', false)
    end

    def view_original_provider
      (data_provider) ? "@ #{data_provider}" : ""
    end

    def view_original_provider_search
      (data_provider) ? "@ #{data_provider}" : ""
    end

    def provider_name
      name = document.fetch('provider_name_ssi', false)
      (name != 'Minnesota Digital Library' && name != 'University of Minnesota Libraries') ? name : false
    end

    def harvested_from
      University of Minnesota Libraries
    end

    def display_title
      document.fetch('title_ssi', '[Missing Title]')
    end

    def display_title_short
      display_title.truncate(50, separator: /\s/)
    end

    def collection
      document.fetch('sourceResource_collection_title_ssi', false)
    end

    def type
      document.fetch('sourceResource_type_ssi', '')
    end

    def is_sound?
      type == 'sound'
    end

    def thumbnail
      (is_sound?) ? sound_icon : thumbnail_image
    end

    def thumbnail_image
      link_to image_tag(img, alt: display_title, style: 'margin-top:20px;', width: '200%'), thumb_url
    end

    def sound_icon
      link_to raw("<span alt=\"#{display_title}\" class=\"icon-search icon-headphones\"></span>"), thumb_url
    end

    def description
      word_limit(strip_tags(document.fetch('sourceResource_description_tesi', '')), 250)
    end

    def to_json
      document.to_json
    end

    private

    def word_limit(text, limit_count)
      words = text.split(' ').compact
      total_words = words.size
      limit = limit_count - 1
      truncated = words[0..limit].join(' ')
      (total_words > limit_count) ? "#{truncated}..." : text
    end
  end
end