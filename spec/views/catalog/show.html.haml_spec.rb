require 'rails_helper'

describe 'catalog/show.html.haml' do
  include ActionView::Helpers
  let(:document) { SolrDocument.new(id:"documentId","sourceResource_type_ssi"=>"image", "isShownAt_ssi"=>"http://dlg.galileo.usg.edu/dlg/aaed/do-th:aarl89.017-004-012", "keywords_ssim"=>["subject1", "subject2"]) }
  let(:related_document_url) { "http://dlg.galileo.usg.edu/aaed/thumbs/aarl89.017-001-014.jpg" }
  let(:related_document_title) { "Sample related image title" }
  let(:related_document) { SolrDocument.new(id:"relatedDocumentId","sourceResource_type_ssi"=>"image", "object_ssi"=>related_document_url, "title_ssi"=>related_document_title) }

  before do
    assign(:document,document)
    allow(view).to receive(:blacklight_config).and_return(CatalogController.blacklight_config)
    allow(view).to receive(:search_session).and_return( {})
    allow(view).to receive(:current_search_session).and_return( {})
    allow(document).to receive(:more_like_this).and_return([related_document])
  end

  it "renders provider when the provider is University of Minnesota Libraries" do
    set_catalog_controller_double!
    document = SolrDocument.new(id:"documentId","provider_name_ssi"=>"University of foo", "isShownAt_ssi"=>"http://dlg.galileo.usg.edu/dlg/aaed/do-th:aarl89.017-004-012")
    assign(:document,document)
    allow(document).to receive(:more_like_this).and_return([related_document])
    render file: 'catalog/show'#, locals: { document: document }
    expect(rendered).to have_selector('.provider')
  end

  it "renders provider when the provider is Minnesota Digital Library" do
    set_catalog_controller_double!
    document = SolrDocument.new(id:"documentId","provider_name_ssi"=>"University of foo", "isShownAt_ssi"=>"http://dlg.galileo.usg.edu/dlg/aaed/do-th:aarl89.017-004-012")
    assign(:document,document)
    allow(document).to receive(:more_like_this).and_return([related_document])
    render file: 'catalog/show'#, locals: { document: document }
    expect(rendered).to have_selector('.provider')
  end

  it "does not render provider when the provider is university of minnesota" do
    set_catalog_controller_double!
    document = SolrDocument.new(id:"documentId","provider_name_ssi"=>"University of Minnesota Libraries", "isShownAt_ssi"=>"http://dlg.galileo.usg.edu/dlg/aaed/do-th:aarl89.017-004-012")
    assign(:document,document)
    allow(document).to receive(:more_like_this).and_return([related_document])
    render file: 'catalog/show'#, locals: { document: document }
    expect(rendered).to_not have_selector('.provider')
  end

  it "renders subjects" do
    render file: 'catalog/show'#, locals: { document: document }
    expect(rendered).to have_selector(".subjects")
    expect(rendered).to have_link("subject1",'/?f%5Bkeywords_ssim%5D%5B%5D=subject1')
    expect(rendered).to have_link("subject2",'/?f%5Bkeywords_ssim%5D%5B%5D=subject2')
  end
  it "renders related content from more_like_this" do
    render file: 'catalog/show'#, locals: { document: document }
    expect(rendered).to have_selector(".related")
    expect(rendered).to have_xpath("//img[@src=\"/89be9cc9f8661292190009fc2df95112b2e7a530.png\" and @title=\"#{related_document_title}\" and @alt=\"#{related_document_title}\"]")
  end
  it "renders technical metadata" do
    render file: 'catalog/show'#, locals: { document: document }
    expect(rendered).to have_selector("#technical-metadata")
    expect(rendered).to have_css("#technical-metadata dt:first-child", text: "\n                Type:\n              ")
    expect(rendered).to have_css("#technical-metadata > dd.blacklight-sourceresource_type_ssi > div", text: "\n                Image\n                ")
  end
end
def set_catalog_controller_double!
  controller.singleton_class.class_eval do
    protected
      def search_action_path(blah)
        'foo bar baz'
      end
      helper_method :search_action_path
  end
end