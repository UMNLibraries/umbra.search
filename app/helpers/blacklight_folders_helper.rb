module BlacklightFoldersHelper
  include Blacklight::Folders::MainAppHelper

  def current_search_path(search_session)
    return '/' if /users/ =~ url_for(:only_path => true)
    query_params = search_session.try(:query_params) || {}
    if query_params.empty?
      return search_action_path(only_path: true)
    else
      return search_action_path(params)
    end
  end

  def current_search_path_escaped(search_session)
    Rack::Utils.escape(current_search_path(search_session))
  end
end
