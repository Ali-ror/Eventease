module Admin
  class BaseController < ApplicationController
    layout "auth"

    private

    def require_admin!
      return if session[:admin_logged_in]

      redirect_to admin_login_path
    end
  end
end
