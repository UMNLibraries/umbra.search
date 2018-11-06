require 'net/http'
class ThumbnailUploader
  attr_reader :cdn_uri,
              :bucket_key,
              :api_uri,
              :api_key,
              :thumb_fallback_url,
              :thumb_url,
              :file_exists_klass,
              :aws_api_klass

  def initialize(bucket_key: :missing_bucket_key,
                 thumb_url: :missing_thumb_url,
                 cdn_uri: ENV['NAILER_CDN_URI'],
                 api_uri: ENV['NAILER_API_URI'],
                 api_key: ENV['NAILER_API_KEY'],
                 thumb_fallback_url: ENV['NAILER_THUMB_FALLBACK_URL'],
                 file_exists_klass: RemoteFileExists,
                 aws_api_klass: AwsApi)
    @cdn_uri            = cdn_uri
    @bucket_key         = bucket_key
    @api_uri            = api_uri
    @thumb_fallback_url = thumb_fallback_url
    @thumb_url          = thumb_url
    @api_key            = api_key
    @file_exists_klass  = file_exists_klass
    @aws_api_klass      = aws_api_klass
  end

  def upload!
    upload unless already_uploaded?
  end

  private

  def api_url
    "#{api_uri}?url=#{thumb_url}&fallback_url=#{thumb_fallback_url}"
  end

  def already_uploaded?
    file_exists_klass.new(url: cdn_url).exists?
  end

  def cdn_url
    "#{cdn_uri}/#{bucket_key}.png"
  end

  def upload
    aws_api_klass.new(url: api_url, api_key: api_key).upload!
  end
end