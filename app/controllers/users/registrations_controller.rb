module Users
  class RegistrationsController < Devise::RegistrationsController
    layout "auth"
  end
end
