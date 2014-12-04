require 'rails_helper'

describe 'catalog/show.html.haml' do
  let(:document) { SolrDocument.new(id:"documentId","sourceResource_type_s"=>"image", "isShownAt_s"=>"http://dlg.galileo.usg.edu/dlg/aaed/do-th:aarl89.017-004-012", "subject_topic_facet"=>["subject1", "subject2"]) }
  let(:related_document_url) { "http://dlg.galileo.usg.edu/aaed/thumbs/aarl89.017-001-014.jpg" }
  let(:related_document_title) { "Sample related image title" }
  let(:related_document) { SolrDocument.new(id:"relatedDocumentId","sourceResource_type_s"=>"image", "object_s"=>related_document_url, "title_display"=>related_document_title) }

  before do
    assign(:document,document)
    # allow(view).to receive(:set_page_title!)
    allow(view).to receive(:blacklight_config).and_return(CatalogController.blacklight_config)
    allow(view).to receive(:search_session).and_return( {})
    allow(view).to receive(:current_search_session).and_return( {})
    allow(document).to receive(:more_like_this).and_return([related_document])
  end
  it "renders subjects" do
    render file: 'catalog/show'#, locals: { document: document }
    expect(rendered).to have_selector(".subjects")
    expect(rendered).to have_link("subject1",'/?f%5Bsubject_topic_facet%5D%5B%5D=subject1')
    expect(rendered).to have_link("subject2",'/?f%5Bsubject_topic_facet%5D%5B%5D=subject2')
  end
  it "renders related content from more_like_this" do
    render file: 'catalog/show'#, locals: { document: document }
    expect(rendered).to have_selector(".related")
    expect(rendered).to have_xpath("//img[@src=\"#{cached_thumbnail_url(url:related_document_url)}\" and @title='#{related_document_title}' and @alt='#{related_document_title}']")
  end

end