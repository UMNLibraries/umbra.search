module PagesHelper

  def path_for_page(page)
    page_path(Page.find(page))
  end

  def active(path)
    (current_page?("/pages/#{path}")) ? 'active' : nil
  end


  def nav_item(link_text, page_path)
    "<li role=\"presentation\" class=\"#{active(page_path)}\">#{link(link_text, path_for_page(page_path))}</li>"
  end

  def link(text, path)
    link = link_to path, :tabindex => '-1', :role => 'menuitem' do
      raw text
    end
  end

  def linked_image(path, img, alt, title, css_classes = nil)
    link_to image_tag(img, alt: alt, title: title, class: "img-responsive page-image #{css_classes}"), path
  end
end
