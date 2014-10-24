module ThumbnailHelper

  def cached_thumbnail_tag(document, image_options)
    #image_tag thumbnail_url(document), image_options
    image_tag cached_thumbnail_url(url:thumbnail_url(document)), image_options
  end

end