class ThumbnailsController < ApplicationController

  # Returns the cached thumbnail if it is available
  # Redirects to the original url if there is no cache
  # Raises ParameterMissing error if no :url is specified in request
  def download
    # uses calculated local filepath for url to prevent SQL injection through :url param
    @file_cache_record = FileCache.find_by_filepath( FileCache.local_filepath_for(params.fetch(:url)))

    if @file_cache_record.nil?
      FileCachePopulatorWorker.perform_async(params[:url])
      redirect_to(params[:url])
    else

      if @file_cache_record.content_valid?
        send_file @file_cache_record.filepath, :disposition=> :inline
      else
        send_file default_thumbnail_path, :disposition=> :inline
      end

    end
  end

  private

  def default_thumbnail_path
    File.join(Rails.root, 'app', 'assets', 'images', 'default_thumbnail.png' )
  end

end