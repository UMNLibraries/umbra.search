require 'rails_helper'

describe FacetsHelper, :type => :helper do
  let(:blacklight_config) { Blacklight::Configuration.new }
  let(:current_user) { create :user_with_moderator_role }
  let(:test_item) { Blacklight::SolrResponse::Facets::FacetItem.new "test_item", 1 }
  let(:test_field_name) { 'test_field_s' }
  let(:facet_item) { Blacklight::SolrResponse::Facets::FacetField.new test_field_name, test_item }

  before(:each) do
    helper.extend Blacklight::Controller
    allow(helper).to receive(:current_user).and_return(current_user)
    allow(helper).to receive(:blacklight_config).and_return(blacklight_config)
  end

  it "includes bootstrap style for displaying type facets" do
    type_facet_solr_field = "type_facet"
    type_facet_item = Blacklight::SolrResponse::Facets::FacetItem.new "image", 38000
    expect(helper.render_selected_facet_value(type_facet_solr_field, type_facet_item)).to include('icon-picture')
    type_facet_item.value = "video"
    expect(helper.render_selected_facet_value(type_facet_solr_field, type_facet_item)).to include('icon-video')
    type_facet_item.value = "text"
    expect(helper.render_selected_facet_value(type_facet_solr_field, type_facet_item)).to include('icon-doc-text')
    type_facet_item.value = "sound"
    expect(helper.render_selected_facet_value(type_facet_solr_field, type_facet_item)).to include('icon-headphones')
  end

  context "when the current user has the moderator role it" do
    it "hides a facet restricted only to a user with the librarian role" do
      blacklight_config.add_facet_field test_field_name, :restricted_to_roles => ['librarian']
      expect(helper.should_render_facet?(facet_item)).to be false
    end

    it "shows a facet restricted only to a user with the moderator role" do
      blacklight_config.add_facet_field test_field_name, :restricted_to_roles => ['moderator']
      expect(helper.should_render_facet?(facet_item)).to be true
    end
  end
end
