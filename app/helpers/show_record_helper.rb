module ShowRecordHelper
  def img
    @document.fetch('object_s', false).to_s
  end

  def thumb_url
    @document.fetch('isShownAt_s', false)
  end

  def subjects
    @document.fetch('subject_topic_facet', false)
  end

  def rights
    @document.fetch('sourceResource_rights_s', false)
  end

  def data_provider
    @document.fetch('dataProvider_s', false)
  end

  def provider_name
    @document.fetch('provider_name_s', false)
  end
  def display_title
    @document.fetch('title_display', false)
  end

  def display_title
    @document.fetch('title_display', false)
  end

  def collection
    @document.fetch('sourceResource_collection_title_s', false)
  end

  def type
    @document.fetch('sourceResource_type_s', '')
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
    @document.fetch('sourceResource_description_txt', false)
  end

  def set_page_title!
    @page_title = t('blacklight.search.show.title', :document_title => document_show_html_title, :application_name => application_name).html_safe
  end
end