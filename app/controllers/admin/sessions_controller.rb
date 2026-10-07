module Admin
  class SessionsController < BaseController
    ADMIN_EMAIL = "admin@eventease.com"
    ADMIN_PASSWORD = "Admin123!"

    def new
    end

    def create
      email = params[:email].to_s.strip.downcase
      password = params[:password].to_s

      if email == ADMIN_EMAIL && password == ADMIN_PASSWORD
        session[:admin_logged_in] = true
        redirect_to admin_dashboard_path
      else
        flash.now[:alert] = "Invalid admin credentials."
        render :new, status: :ok
      end
    end

    def destroy
      session.delete(:admin_logged_in)
      redirect_to admin_login_path
    end
  end
end
