module Admin
  class DashboardController < BaseController
    before_action :require_admin!

    def show
    end
  end
end
