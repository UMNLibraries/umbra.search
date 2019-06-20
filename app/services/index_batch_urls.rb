require 'open-uri'
require 'cgi'
require 'forwardable'


# Parse the last page URL, return the page number and per page count
class ApiLastPage
  attr_reader :url
  def initialize(url: :MISSING_URL)
    @url = url
  end

  def number
    query['page[number]'].first.to_i
  end

  def per_page_count
    query['page[size]'].first.to_i
  end

  private

  def query
    CGI.parse(uri.query)
  end

  def uri
    URI.parse(url)
  end
end

# Get a list of API URLs for use in Sidekiq indexing jobs
class IndexBatchUrls
  extend Forwardable
  def_delegators :@last_page, :per_page_count

  attr_reader :start_url,
              :http_klass,
              :last_page_klass,
              :last_page
  def initialize(start_url: :MISSING_START_URL,
                 http_klass: URI,
                 last_page_klass: ApiLastPage)
    @start_url = start_url
    @http_klass = http_klass
    @last_page_klass = last_page_klass
    @last_page ||= last_page_klass.new(url: last_page_url)
  end

  def to_a
    (1..last_page.number).map do |page|
      "#{start_url}&page[number]=#{page}&page[size]=#{per_page_count}"
    end
  end

  private

  def last_page_url
    JSON.parse(response).fetch('links').fetch('last')
  end

  def response
    start_time = Time.now
    http_klass.open(start_url, read_timeout: 601) { |http| http.read  }
  rescue Exception => error
    elapsed = Time.now - start_time
    raise "Request Failed for #{start_url} with error #{error} and elapsed time of #{elapsed}"
  end
end
