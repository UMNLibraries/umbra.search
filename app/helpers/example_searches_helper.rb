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
        title: "Civil Rights in the 1800's",
        q: "1800's civil rights",
        fq: 'keywords_ssim:"Civil Rights"',
        thumbnail: 'https://www.umbrasearch.org/thumbnail?url=http%3A%2F%2Fcredo.library.umass.edu%2Fimages%2Fresize%2F175x200%2Fmums312-b287-i016-001.png'
      }
    ]
  end
end