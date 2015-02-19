require 'digest/sha1'
require 'open-uri'

class FileCache < ActiveRecord::Base

  def content_valid?
    valid_content
  end

  # Store the content from the given url in S3
  def self.store(url)
    local_filepath = local_filepath_for(url)
    init_thumbnail_cache_dir!(local_filepath)
    file_cache_record = FileCache.new(url:url, filepath:local_filepath)
    http_response = fetch_remote_image(url)

    if remote_file_is_valid?(http_response)
      file_cache_record.valid_content = true
      file_cache_record.content_type = http_response.content_type
      File.open(local_filepath, 'wb') do |file|
        file << http_response.read
      end
      downsize_image local_filepath
    else
      file_cache_record.valid_content = false
    end
    file_cache_record.save
    file_cache_record
  end

  def self.downsize_image(filepath)
    image = MiniMagick::Image.open(filepath)
    image.resize "175x200"
    image.write(filepath)
  end

  # Make sure the cache directory for our files exists
  def self.init_thumbnail_cache_dir!(local_filepath)
    FileUtils.mkdir_p(File.dirname(local_filepath)) unless Dir.exists?(File.dirname(local_filepath))
  end

  # Any kind of error retrieving the file returns false, ultimately resulting
  # in this file being
  # flagged as invalid
  def self.fetch_remote_image(url)
    open(url)
  rescue
    false
  end

  # Generate a persistent path for storing a copy of the file
  # The file path will include a directory whose name is a SHA digest of the given string you pass to this method (ie. the URL you're downloading from)
  # The file name is extracted from the remote_url
  def self.local_filepath_for(remote_url)
    File.join(local_tmp_dir, Digest::SHA1.hexdigest(remote_url) )
  end

  # Path to directory where temp files will be stored
  def self.local_tmp_dir
    #Platform independent way of showing a File path. Empty String ('') means the root
    File.join(Rails.root, 'cache', 'thumbnails')
  end

  private

  def self.remote_file_is_valid?(http_response)
    return false if !http_response
    unwanted_content_types = ["text/html"]
    if (http_response.status.first != "200") || (unwanted_content_types.include?(http_response.content_type))
      return false
    else
      return true
    end
  end
end