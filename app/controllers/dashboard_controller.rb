class DashboardController < ApplicationController
  before_action :authenticate_user!
  layout "authenticated"

  def show
  end
end
