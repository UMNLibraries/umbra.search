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
        title: "African American Firsts",
        q: '"first african american"',
        fq: [],
        thumbnail: 'welcome-shirley.png',
        tour: 'phrase-search'
      },
      {
        title: "Video from the Civil Rights Movement",
        q: '"Civil rights movement"',
        fq: ['sourceResource_type_ssi:video'],
        thumbnail: 'king.png',
        tour: 'search-with-facet-video'
      },
      {
        title: "Underground Railroad (Advanced Search)",
        q: '+"underground railroad" -"subways"',
        fq: [],
        thumbnail: 'railroad.png',
        tour: 'operator-search'
      },
      {
        title: "The Creation of the Niagara Movement",
        q: '"Niagara movement"',
        fq: [],
        thumbnail: 'niagara.png',
        tour: 'phrase-search'
      },
      {
        title: "The Repertoire of Alvin Ailey American Dance Theater",
        q: '"Alvin ailey"',
        fq: ['keywords_ssim:"Alvin Ailey American Dance Theater"'],
        thumbnail: 'dance.png',
        tour: 'search-with-facet-subject'
      }
    ]
  end
end