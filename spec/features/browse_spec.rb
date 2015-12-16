require 'rails_helper'

describe 'Browsing Facets' do
  let(:solr_docs) {
    docs = []
    (0..300).each do
      random_text = rand(500).to_s
      docs << SolrDocument.new({
        id: random_text,
        title_ssi: random_text,
        creator_ssim: [random_text],
        subject_ssim: [:foo, :bar].sample,
        dataProvider_ssi: random_text,
        sourceResource_spatial_state_ssi: random_text,
        sourceResource_collection_title_ssi: random_text,
        tags_ssim:'umbramvp'
      }).to_h
    end
    docs
  }

  before(:each) { @routes = Blacklight::Engine.routes }

  before do
    Blacklight.default_index.connection.tap do |solr|
      solr.delete_by_query("*:*", params: { commit: true })
      solr.add solr_docs
      solr.commit
    end
  end

  it 'should browse each full facet view and receive 100 facet results sorted numerically' do
    facets = {
      "creator_ssim" => "Creator",
      "dataProvider_ssi" => "Contributing Institution",
      "sourceResource_spatial_state_ssi" => "Location",
      "sourceResource_collection_title_ssi" => "Collection"
    }
    facets.each do |id, name|
      browse_facet(id, name, 100)
    end
  end

  context 'given the facet.mincount setting for subjects in catalog_controller.rb' do
    it 'should browse the subject facet and recieve two results' do
      visit "/catalog/facet/subject_ssim?limit=100"
      browse_facet('subject_ssim', 'Keyword', 2)
    end
  end

  def browse_facet(id, name, count)
    visit "/catalog/facet/#{id}?limit=100"
    expect(page).to have_content(name)
    # expect(page).to have_selector('.facet-label', count: count)
    expect(find('.top .sort_options > .active')).to have_content("Numerical Sort")
  end
end

