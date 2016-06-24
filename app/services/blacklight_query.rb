class BlacklightQuery
  attr_reader :params, :client, :url_method

  def initialize(params: {}, client: Blacklight.default_index.connection, url_method: Proc.new)
    @params     = params
    @client     = client
    @url_method = url_method
  end

  def url(extra_params = {})
    url_method.call(params.merge(extra_params))
  end

end