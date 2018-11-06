require 'rails_helper'

describe CatalogController, :type => :controller do
  it "should include 'more like this' behaviors" do
    expect(controller.class.included_modules).to include BlacklightMoreLikeThis::SolrHelperExtension
    expect(controller.class.search_params_logic).to include :add_solr_mlt_parameters
  end
end