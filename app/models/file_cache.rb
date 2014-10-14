require 'digest/sha1'
require 'open-uri'

class FileCache

  # Look for the given url in S3 cache and return the best URL for accessing it.
  # If url is cached, returns the public url for the S3 object. If url is not cached, returns the original url.
  def self.lookup(url)
    puts "Looking Up: #{url}"
    unless url.nil? || url.empty?
      obj = objects[url]
    end
    if obj && obj.exists?
      return  s3_url_for(obj).to_s
    else
      FileCachePopulatorWorker.perform_async(url)
      return url
    end
  end

  # Store the content from the given url in S3
  def self.store(url)
    temp_file_path =  temp_file_path_for(url)
    FileUtils.mkdir_p(File.dirname(temp_file_path)) unless Dir.exists?(File.dirname(temp_file_path))
    #%x"wget #{url} -O #{temp_file_path}"
    open(temp_file_path, 'wb') do |file|
      file << open(url).read
    end
    objects[url].write(file:temp_file_path)
  end

  # Returns an authorized S3 url for the corresponding S3 content
  # Accepts all the same parameters as AWS::S3::S3Object.url_for
  # Default Values for options Hash:
  #   * method: :read
  #   * The url authorization expires afte 1.5 hours.
  #   * response_content_disposition: "inline; filename=#{file_name}"
  def self.s3_url_for(s3_object, method=:read, options={})
    default_options = {expires: 60 * 60 * 1.5}
    options = default_options.merge(options)
    return s3_object.url_for(method, options)
  end

  # The S3 connection used by FileCache
  def self.s3
    AWS::S3.new
  end

  # The S3 bucket used by FileCache
  def self.bucket
    s3.buckets['umbra.assets']
  end

  # The objects in the S3 bucket used by FileCache
  def self.objects
    bucket.objects
  end

  # Generate path for storing a temporary copy of the file
  # The filename is a SHA digest of the given string you pass to this method (ie. the URL you're downloading from)
  def self.temp_file_path_for(string)
    File.join(local_tmp_dir, Digest::SHA1.hexdigest(string))
  end

  # Path to directory where temp files will be stored
  def self.local_tmp_dir
    #Platform independent way of showing a File path. Empty String ('') means the root
    File.join('', 'tmp', 'umbra', Rails.env)
  end
end