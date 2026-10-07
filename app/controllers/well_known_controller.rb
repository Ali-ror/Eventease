class WellKnownController < ApplicationController
  # Chrome DevTools requests this path when open; avoid RoutingError noise in logs.
  def chrome_devtools
    render json: {}
  end
end
