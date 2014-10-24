require 'digest/sha1'
require 'open-uri'

class FileCache

  # Look for the given url in S3 cache and return the best URL for accessing it.
  # If url is cached, returns the local filepath of the cached file. Otherwise returns false.
  def self.lookup(url)
    if url.nil? || url.empty?
      return false
    end
    local_filepath =  local_filepath_for(url)
    if File.exist?(local_filepath)
      return  local_filepath.to_s
    else
      FileCachePopulatorWorker.perform_async(url)
      return false
    end
  end

  # Store the content from the given url in S3
  def self.store(url)
    local_filepath =  local_filepath_for(url)
    FileUtils.mkdir_p(File.dirname(local_filepath)) unless Dir.exists?(File.dirname(local_filepath))
    open(local_filepath, 'wb') do |file|
      file << open(url).read
    end
    local_filepath
  end

  # Generate a persistent path for storing a copy of the file
  # The file path will include a directory whose name is a SHA digest of the given string you pass to this method (ie. the URL you're downloading from)
  # The file name is extracted from the remote_url
  def self.local_filepath_for(remote_url)
    begin
      uri = URI.parse(remote_url)
    rescue
      puts "BAD URI: "+ remote_url
    end


    File.join(local_tmp_dir, Digest::SHA1.hexdigest(remote_url), File.basename(uri.path) )
  end

  # Path to directory where temp files will be stored
  def self.local_tmp_dir
    #Platform independent way of showing a File path. Empty String ('') means the root
    File.join(Rails.root, 'cache', 'thumbnails')
  end
end