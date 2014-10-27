require 'digest/sha1'
require 'open-uri'

class FileCache < ActiveRecord::Base

  def content_valid?
    valid_content
  end

  # Store the content from the given url in S3
  def self.store(url)
    local_filepath =  local_filepath_for(url)
    FileUtils.mkdir_p(File.dirname(local_filepath)) unless Dir.exists?(File.dirname(local_filepath))
    file_cache_record = FileCache.new(url:url, filepath:local_filepath)
    begin
      http_response = open(url)
      file_cache_record.content_type = http_response.content_type
    rescue OpenURI::HTTPError => error
      http_response = error.io
      file_cache_record.content_type =  http_response.status.first
      file_cache_record.valid_content = false
    end

    if remote_file_is_valid?(http_response)
      file_cache_record.valid_content = true
      File.open(local_filepath, 'wb') do |file|
        file << http_response.read
      end
    else
      file_cache_record.valid_content = false
    end
    file_cache_record.save
    file_cache_record
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
    unwanted_content_types = ["text/html"]
    if (http_response.status.first != "200") || (unwanted_content_types.include?(http_response.content_type))
      return false
    else
      return true
    end
  end
end