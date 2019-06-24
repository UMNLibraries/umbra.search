require 'rails_helper'

describe DocumentPresenter, :type => :model do
  let(:document) { Hash.new }
  let(:controller) { CatalogController.new }
  let(:blacklight_config) { Blacklight::Configuration.new }
  let(:subject) { DocumentPresenter.new(document, controller)}
  before(:each) do
    allow(controller).to receive(:blacklight_config).and_return(blacklight_config)
  end

  value_with_urls = "Digitized versions of these maps can be found at http://dc.lib.unc.edu/u?/ncmaps,1435 and http://dc.lib.unc.edu/u?/ncmaps,9471."
  it "should render urls as html links" do
    rendered_text = subject.render_field_value(value_with_urls)
    rendered_html = Capybara::Node::Simple.new(rendered_text)
    expect( rendered_html ).to have_link("http://dc.lib.unc.edu/u?/ncmaps,1435", href: "http://dc.lib.unc.edu/u?/ncmaps,1435")
    expect( rendered_html ).to have_link("http://dc.lib.unc.edu/u?/ncmaps,9471", href: "http://dc.lib.unc.edu/u?/ncmaps,9471")
  end
end
