module ShowRecordHelper
  def show_document
    @presenter_document ||= presenter @document
  end

  def set_page_title!
    @page_title = t('blacklight.search.show.title', :document_title => document_show_html_title, :application_name => application_name).html_safe
  end
end