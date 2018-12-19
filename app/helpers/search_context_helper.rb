module SearchContextHelper
  def current_search
    request.original_url.gsub(/\/$/, '')
  end

  def current_search_json
    current_search.gsub(/\?|catalog\/\?|catalog\?/, 'catalog.json?')
  end

  def uri
    URI::parse(request.original_url)
  end

  def json_page_link
    link_to "#{uri.scheme}://#{uri.host}:#{uri.port}#{uri.path}.json", json_link_attrs do
      raw '<div class="icon-json text-center">
              <span class="sr-only">Download JSON</span>
          </div>'
    end
  end

  def json_link_attrs
    {
      id: 'json-link',
      rel: 'nofollow',
      alt: 'JSON Output.',
      title: 'Full Record Metadata JSON'
    }
  end

  def json_result_link
    link_to current_search_json, json_link_attrs do
      raw '<div class="icon-json pull-right">
          <span class="sr-only">Download JSON</span>
      </div>'
    end
  end
end