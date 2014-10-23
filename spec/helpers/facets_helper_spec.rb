require 'rails_helper'

describe FacetsHelper, :type => :helper do
  let(:blacklight_config) { Blacklight::Configuration.new }

  before(:each) do
    helper.extend Blacklight::Controller
    allow(helper).to receive(:blacklight_config).and_return(blacklight_config)
  end

  it "includes bootstrap style for displaying type facets" do
    type_facet_solr_field = "type_facet"
    type_facet_item = Blacklight::SolrResponse::Facets::FacetItem.new "image", 38000
    expect(helper.render_selected_facet_value(type_facet_solr_field, type_facet_item)).to include('icon-picture')
    type_facet_item.value = "moving image"
    expect(helper.render_selected_facet_value(type_facet_solr_field, type_facet_item)).to include('icon-video')
    type_facet_item.value = "video"
    expect(helper.render_selected_facet_value(type_facet_solr_field, type_facet_item)).to include('icon-video')
    type_facet_item.value = "text"
    expect(helper.render_selected_facet_value(type_facet_solr_field, type_facet_item)).to include('icon-doc-text')
    type_facet_item.value = "sound"
    expect(helper.render_selected_facet_value(type_facet_solr_field, type_facet_item)).to include('icon-headphones')
  end
end
