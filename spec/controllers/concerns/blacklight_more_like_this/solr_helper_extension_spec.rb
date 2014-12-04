require 'rails_helper'

describe BlacklightMoreLikeThis::SolrHelperExtension do
  controller(ApplicationController) do
    include Blacklight::Catalog
    include BlacklightMoreLikeThis::SolrHelperExtension
  end

  describe "add_solr_mlt_parameters" do
    context "when constructing requests for a specific document" do
      let(:solr_parameters) { {id:"documentId"}  }
      it "adds mlt params to solr_parameters" do
        controller.add_solr_mlt_parameters solr_parameters, {}
        expect(solr_parameters).to eq ({id:"documentId", mlt:true, 'mlt.fl' => 'title_t,subject_t,creator_t',
                                         'mlt.count' => 20,
                                         'mlt.mintf' => 1} )
      end
    end
    context "when constructing regular search requests" do
      let(:solr_parameters) { {}  }
      it "doesn't do anything" do
        controller.add_solr_mlt_parameters solr_parameters, {}
        expect(solr_parameters).to eq({})
      end
    end

  end

  describe "solr_doc_params" do
    it "extends solr_doc_params to include mlt params" do
      expect(controller).to receive(:add_solr_mlt_parameters)
      controller.solr_doc_params
    end
  end
end