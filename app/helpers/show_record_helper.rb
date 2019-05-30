module ShowRecordHelper
  def show_document
    @presenter_document ||= presenter @document
  end

  def set_page_title!
    @page_title = t('blacklight.search.show.title',
                    :document_title => show_document.display_title,
                    :application_name => application_name).html_safe
  end

  def show_field_label(doc, name)
    render_document_show_field_label doc, field: name
  end

  def show_field_value(doc, field)
    value = @presenter_document.render_document_show_field_value :document => doc, field: field
    label = show_field_label(doc, field)
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