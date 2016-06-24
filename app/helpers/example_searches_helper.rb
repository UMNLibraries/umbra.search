module ExampleSearchesHelper

  def example_searches_with_counts
    example_searches.map do |search|
      ExampleSearchPresenter.new(search, params: blacklight_config[:default_solr_params], template: self)
    end
  end

  private

  def example_searches
    searches.map { |search| ExampleSearch.new(search) }
  end

  def searches
    [
      {
        title: "Find Jazz Musicians",
        q: '"Jazz Musicians"',
        fq: '',
        thumbnail: 'dizzy-g.png',
        tour: 'phrase-search'
      }
    ]
  end
end