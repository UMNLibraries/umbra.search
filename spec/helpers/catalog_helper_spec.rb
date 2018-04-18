require 'rails_helper'

describe CatalogHelper, :type => :helper do
  let(:blacklight_config) { CatalogController.new.blacklight_config }
  before(:each) do
    helper.extend Blacklight::Controller
    allow(helper).to receive(:blacklight_config).and_return(blacklight_config)
  end
end
