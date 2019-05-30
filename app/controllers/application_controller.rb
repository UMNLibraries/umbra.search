class ApplicationController < ActionController::Base
  # Adds a few additional behaviors into the application controller
  include Blacklight::Controller
  layout 'blacklight'

  before_filter :configure_permitted_parameters, if: :devise_controller?
  include Blacklight::SearchContext
  # Adds a few additional behaviors into the application controller
  include Blacklight::Controller
  # Please be sure to impelement current_user and user_session. Blacklight depends on
  # these methods in order to perform user specific actions.

  layout 'umbra' # use layouts/umbra instead of default layouts/blacklight

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password,
    :password_confirmation, :remember_me])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password,
    :password_confirmation, :current_password])
  end

  def devise_params
    params.require('user').permit(:redirect_to)
  end

  def seconds_to_expiration
   if params[:seconds_to_expiration] && can_expire_snapshots?
    params[:seconds_to_expiration].to_i
    else
      one_day
    end
  end

  def can_expire_snapshots?
    current_user && current_user.has_role?('admin')
  end

  def one_day
    (60*60*24)
  end
end
