# Example searches are a UI feature used on the home page. They help users
# understand how to search umbra. This object models the main components
# of an example search: A title, the search itself, and the number of results
# for a given example search
class ExampleSearchPresenter  < BasePresenter
  attr_accessor :solr, :params
  presents :search
  delegate :title, to: :search

  def initialize(object, template: nil, params: {}, solr: Blacklight.default_index.connection)
    super(object, template: template)
    @solr   = solr
    @params = params
  end

  def items_found
    "#{solr_search['response']['numFound']} items"
  end

  def url
    h.catalog_index_url params.merge(query_params)
  end

  def query_params
    {:q => search.q, :fq => search.fq}
  end

  private

  def solr_search
    solr.get('select', :params => query_params.merge(:fl => '', :rows => 1))
  end
end