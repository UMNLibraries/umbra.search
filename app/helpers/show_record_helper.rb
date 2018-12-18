module ShowRecordHelper
  def show_document
    @presenter_document ||= presenter @document
  end

  def set_page_title!
    @page_title = t('blacklight.search.show.title', :document_title => document_show_html_title, :application_name => application_name).html_safe
  end

  def show_field_label(doc, name)
    render_document_show_field_label doc, field: name
  end

  def show_field_value(doc, name)
    value = render_document_show_field_value doc, field: name
    label = show_field_label(doc, name)
    if titlizables.include? label
      value.titleize
    else
      value
    end
  end

  def titlizables
    ['Format:', 'Created Date:', 'Type:']
  end
end