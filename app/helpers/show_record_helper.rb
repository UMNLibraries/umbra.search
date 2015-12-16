module ShowRecordHelper

  def document_set(document)
    @document = document
  end

  def img
    @document.fetch('object_ssi', false).to_s
  end

  def thumb_url
    @document.fetch('isShownAt_ssi', false)
  end

  def subjects
    @document.fetch('subject_ssim', false)
  end

  def rights
    @document.fetch('sourceResource_rights_ssi', false)
  end

  def data_provider
    @document.fetch('dataProvider_ssi', false)
  end

  def view_original_provider
    (data_provider) ? "@ #{data_provider}" : ""
  end

  def view_original_provider_search
    (data_provider) ? "@ #{data_provider}" : ""
  end

  def provider_name
    name = @document.fetch('provider_name_ssi', false)
    (name != 'Minnesota Digital Library' && name != 'University of Minnesota Libraries') ? name : false
  end

  def provider_name_facet_link
    render_facet_link('provider_name_ssi', provider_name)
  end

  def harvested_from
    University of Minnesota Libraries
  end

  def display_title
    @document.fetch('title_ssi', '[Missing Title]')
  end

  def display_title_short
    display_title.truncate(50, separator: /\s/)
  end

  def collection
    @document.fetch('sourceResource_collection_title_ssi', false)
  end

  def type
    @document.fetch('sourceResource_type_ssi', '')
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
    word_limit(strip_tags(@document.fetch('sourceResource_description_tesi', '')), 250)
  end

  def set_page_title!
    @page_title = t('blacklight.search.show.title', :document_title => document_show_html_title, :application_name => application_name).html_safe
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