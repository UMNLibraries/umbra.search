require 'rails_helper'

describe 'Editing a folder' do
  let(:solr_docs) {
    docs = []
    (0..200).each do
      docs << SolrDocument.new({
        id: rand(500),
        title_display: rand(500),
        creator_facet: [rand(500)],
        subject_topic_facet: [rand(500)],
        dataProvider_s: rand(500),
        sourceResource_spatial_state_s: rand(500),
        sourceResource_collection_title_s: rand(500)
      }).to_h
    end
    docs
  }

  before(:each) { @routes = Blacklight::Engine.routes }

  before do
    Blacklight.solr.tap do |solr|
      solr.delete_by_query("*:*", params: { commit: true })
      solr.add solr_docs
      solr.commit
    end
  end

  it 'should browse each full facet view and receive 100 facet results sorted numerically' do
    facets = {
      "creator_facet" => "Author",
      "subject_topic_facet" => "Keyword",
      "dataProvider_s" => "Contributing Institution",
      "sourceResource_spatial_state_s" => "State",
      "sourceResource_collection_title_s" => "Collection"
    }
    facets.each do |id, name|
      browse_facet(id, name)
    end
  end

  def browse_facet(id, name)
    visit "/catalog/facet/#{id}?limit=100"
    expect(page).to have_content(name)
    expect(page).to have_selector('.facet-label', count: 100)
    expect(find('.top .sort_options > .active')).to have_content("Numerical Sort")
  end
end

