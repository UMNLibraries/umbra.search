module FeaturedImagesHelper

  # Returns a styled div containing the publication status of the featured_image
  def published_status(featured_image)
    if featured_image.published
      content_tag :div, "Published", class:"text-success"
    else
      content_tag :div, "Not Published", class:"text-warning"
    end
  end

  # Returns the path to use for previewing the Umbra Search homepage with the given featured_image
  def featured_image_preview_path(featured_image)
    root_path(featured_image:featured_image)
  end

  # Returns a link to the record with the given record_id
  # If record_id is nil or empty, returns a styled span reading "Unspecified"
  # @param String, link_text Text to display in the link.  Defaults to using the record_id
  def link_to_featured_record(record_id, link_text=nil)
    if record_id.nil? || record_id.empty?
      content_tag :span, "Unspecified", class:"text-danger"
    else
      if link_text.nil?
        link_text = record_id
      end
      link_to link_text, solr_document_path(record_id.to_s)
    end
  end

  # Returns a FeaturedImage selected randomly from the current _published_ FeaturedImage objects
  def random_featured_image
    # This uses database-specific random method
    FeaturedImage.where(published:true).order("RAND()").first # mysql example
    # FeaturedImage.where(published:true).order("RANDOM()").first # postgres example
  end
end