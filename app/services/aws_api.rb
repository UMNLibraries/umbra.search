class AwsApi
  attr_reader :uri, :api_key, :http_klass, :post_klass
  def initialize(url: :missing_url,
                 api_key: :missing_api_key,
                 http_klass: Net::HTTP,
                 post_klass: Net::HTTP::Post)
    @uri        = URI(url)
    @api_key    = api_key
    @http_klass = http_klass
    @post_klass = post_klass
  end

  def upload!
    res = http_klass.start(uri.hostname,
                           uri.port,
                           :use_ssl => true) do |http|
      http.request(post_request)
    end
  end

  def post_request
    req = post_klass.new(uri)
    req['x-api-key'] = api_key
    @post_request ||=  req
  end
end