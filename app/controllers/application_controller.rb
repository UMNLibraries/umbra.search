class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # Adds a few additional behaviors into the application controller 
  include Blacklight::Controller
  # Please be sure to impelement current_user and user_session. Blacklight depends on 
  # these methods in order to perform user specific actions. 

  layout 'umbra' # use layouts/umbra instead of default layouts/blacklight

  # Adds a few additional behaviors into the application controller 
   include Blacklight::Controller
  include Blacklight::Folders::ApplicationControllerBehavior
  # Please be sure to impelement current_user and user_session. Blacklight depends on 
  # these methods in order to perform user specific actions. 

  layout 'umbra' # use layouts/umbra instead of default layouts/blacklight

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password,
      :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password,
      :password_confirmation, :current_password) }
  end

  # See: https://github.com/plataformatec/devise/wiki/How-To%3A-Redirect-to-a-specific-page-on-successful-sign-in-and-sign-out
  def after_sign_in_path_for(resource)
    redirect_to_sanitized || super
  end

  # See: https://github.com/plataformatec/devise/wiki/How-To%3A-Redirect-to-a-specific-page-on-successful-sign-in-and-sign-out
  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end

  def redirect_to_sanitized
    return nil if !devise_params[:redirect_to]
    # force redirect to local paths, prevent someone from using http://badsite.com
    "/#{devise_params[:redirect_to].gsub(/^\/{1}/,'')}"
  end

  def devise_params
    params.require('user').permit(:redirect_to)
  end
end
