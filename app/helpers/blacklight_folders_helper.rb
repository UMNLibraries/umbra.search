module BlacklightFoldersHelper
  include Blacklight::Folders::MainAppHelper

  def current_search_path
    return '/' if /users/ =~ url_for(:only_path => true)
    query_params = current_search_session.try(:query_params) || {}
    if query_params.empty?
      return search_action_path(only_path: true)
    else
      return search_action_path(params)
    end
  end

  def current_search_path_escaped
    Rack::Utils.escape(current_search_path)
  end
end
