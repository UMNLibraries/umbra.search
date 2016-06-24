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
        title: "Try a Search for \"Jazz Musicians\"",
        q: '"Jazz Musicians"',
        fq: '',
        thumbnail: 'dizzy-g.png',
        tour: 'phrase-search'
      },
      {
        title: "Try a Search for Jazz Recordings",
        q: 'jazz',
        fq: 'sourceResource_type_ssi:sound',
        thumbnail: 'jazz-sound.png',
        tour: 'search-with-facet'
      },
      {
        title: "Try an Advanced Search",
        q: '+"Selma" -"selma burke"',
        fq: '',
        thumbnail: 'selma.png',
        tour: 'operator-search'
      }
    ]
  end
end