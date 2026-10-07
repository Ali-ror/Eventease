module Users
  class PasswordsController < Devise::PasswordsController
    layout "auth"

    def create
      email = resource_params[:email].to_s.strip.downcase
      user = User.find_by(email: email)

      if user
        raw_token, encrypted_token = Devise.token_generator.generate(User, :reset_password_token)
        user.reset_password_token = encrypted_token
        user.reset_password_sent_at = Time.current
        user.save(validate: false)

        reset_link = reset_password_url(reset_password_token: raw_token, host: request.host_with_port, protocol: request.protocol)
        message = "[EventEase] Password reset link for #{email}:\n#{reset_link}\n"
        Rails.logger.info message
        $stdout.puts message
      end

      flash[:notice] = "Reset instructions sent. Please check the server console for the reset link during development."
      redirect_to forgot_password_path
    end

    def update
      super
    end

    protected

    def after_resetting_password_path_for(_resource)
      login_path
    end
  end
end
