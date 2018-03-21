module ThumbnailHelper

  def cached_thumbnail_tag(document, image_options)
    title = presenter(document).render_document_index_label document_show_link_field(document)
    image_options = {class:"thumbnail", alt:title.strip, title:title.strip, property:"og:image"}.merge(image_options)
    if has_thumbnail_field?(document)
      image_tag cached_thumb_url(thumbnail_url(document)), image_options
    else
      image_tag DEFAULT_THUMBNAIL, image_options
    end
  end

  # Allows us to not show the thumbnail at all if the document thumbnail field
  # is altogether missing
  def has_thumbnail_field?(document)
    document.has?(blacklight_config.view_config(document_index_view_type).thumbnail_field)
  end



  # Returns the cached thumbnail if it is available
  # Redirects to the original url if there is no cache
  # Raises ParameterMissing error if no :url is specified in request
  def cached_thumb_url(url)
    # uses calculated local filepath for url to prevent SQL injection through :url param
    @file_cache_record = FileCache.find_by_filepath( FileCache.local_filepath_for(url))

    if @file_cache_record.nil?
      FileCachePopulatorWorker.perform_async(url)
      return url
    else

      if @file_cache_record.content_valid?
        return @file_cache_record.filepath.gsub(public_dir, '')
      else
        return DEFAULT_THUMBNAIL
      end

    end
  end

  def public_dir
    File.join(Rails.root, 'public')
  end
end