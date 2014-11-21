module ThumbnailHelper

  def cached_thumbnail_tag(document, image_options)
    #image_tag thumbnail_url(document), image_options
    image_tag cached_thumbnail_url(url:thumbnail_url(document)), image_options if has_thumbnail?(document)
  end

  # Allows us to not show the thumbnail at all if the document thumbnail field
  # is altogether missing
  def has_thumbnail?(document)
    document.has?(blacklight_config.view_config(document_index_view_type).thumbnail_field)
  end

end