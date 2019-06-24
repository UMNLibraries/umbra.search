# Example searches are a UI feature used on the home page. They help users
# understand how to search umbra. This object models the main components
# of an example search: A title, the search itself, and the number of results
# for a given example search
class ExampleSearchPresenter < BasePresenter
  attr_accessor :solr, :params
  presents :search
  delegate :title, :thumbnail, :tour, to: :search

  def initialize(object, template: nil, params: {}, solr: Blacklight.default_index.connection)
    super(object, template: template)
    @solr   = solr
    @params = params
  end

  def items_found
    "#{solr_search['response']['numFound']} items"
  end

  def url
    %Q(/catalog?#{url_params}&q=#{search.q}&#{url_params}#{f}&example-search=#{tour})
  end

  def url_params
    params.to_a.map { |param| "#{param.first.to_s}=#{param.last}" }.join('&')
  end

  def query_params
    {q: search.q, fq: search.fq}
  end

  private

  def f
    search.fq.map do |fq|
      field, value = fq.split(':')
      "&f[#{field}][]=#{value.gsub(/"/, '')}"
    end.join('')
  end

  def solr_search
    solr.get('select', :params => query_params.merge(:fl => '', :rows => 1))
  end
end