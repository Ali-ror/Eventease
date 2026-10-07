module Session
  class ViewModesController < ApplicationController
    before_action :authenticate_user!

    def update
      mode = params[:view_mode].to_s
      session[:view_mode] = mode if %w[host vendor].include?(mode)
      redirect_back(fallback_location: dashboard_path)
    end
  end
end
