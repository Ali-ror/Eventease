class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_view_mode

  def after_sign_in_path_for(_resource)
    session[:view_mode] = "host" if session[:view_mode].blank?
    dashboard_path
  end

  def after_sign_up_path_for(_resource)
    session[:view_mode] = "host"
    dashboard_path
  end

  def after_sign_out_path_for(_resource_or_scope)
    session[:view_mode] = nil
    root_path
  end

  def current_view_mode
    mode = session[:view_mode].to_s
    return mode if %w[host vendor].include?(mode)

    "host"
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name])
  end
end
