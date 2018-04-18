require 'digest/sha1'

class ThumbnailCacheController < ActionController::Base
  def update
    upload! if (!doc.nil?)
    render :nothing => true
  end

  def upload!
    ThumbnailUploader.new(bucket_key: bucket_key,
                          thumb_url: thumb_url).upload!
  end

  def bucket_key
    Digest::SHA1.hexdigest doc['object_ssi']
  end

  def thumb_url
    CGI.escape doc['object_ssi']
  end

  def doc
    @doc ||= SolrClient.find_record(thumbnail_params[:record_id])
  end

  def thumbnail_params
    params.permit(:record_id)
  end
end