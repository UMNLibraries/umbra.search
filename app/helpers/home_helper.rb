module HomeHelper

  def is_homepage?
    current_page?('/') && !has_search_parameters?
  end
end
