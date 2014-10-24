class ThumbnailsController < ApplicationController

  # Returns the cached thumbnail if it is available
  # Redirects to the original url if there is no cache
  # Raises ParameterMissing error if no :url is specified in request
  def download
    local_path = FileCache.lookup( params.fetch(:url) )
    if local_path
      if File.zero?(local_path)
        send_file default_thumbnail_path
      else
        send_file local_path
      end
    else
      redirect_to(params[:url])
    end
  end

  private

  def default_thumbnail_path
    File.join(Rails.root, 'app', 'assets', 'images', 'default_thumbnail.png' )
  end

end