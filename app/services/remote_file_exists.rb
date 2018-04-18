require "rest-client"

class RemoteFileExists
  attr_reader :url, :http_klass
  def initialize(url: :missing_url,
                 http_klass: Net::HTTP)
    @url        = url
    @http_klass = http_klass
  end

  def exists?
    valid_codes.include?(code)
  end

  private

  def code
      RestClient.head(url).code
    rescue RestClient::Exception => error
      error.http_code
  end

  def valid_codes
    [200, 301, 302, 303, 304, 307, 308]
  end
end