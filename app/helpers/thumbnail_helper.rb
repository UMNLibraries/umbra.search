module ThumbnailHelper

  def cached_thumbnail_tag(document, image_options)
    title = render_document_index_label document, label: document_show_link_field(document)
    image_options = {class:"thumbnail", alt:title.strip, title:title.strip}.merge(image_options)
    image_tag cached_thumbnail_url(url:thumbnail_url(document)), image_options if has_thumbnail_field?(document)
  end

  # Allows us to not show the thumbnail at all if the document thumbnail field
  # is altogether missing
  def has_thumbnail_field?(document)
    document.has?(blacklight_config.view_config(document_index_view_type).thumbnail_field)
  end

end