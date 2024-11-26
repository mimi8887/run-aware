class RoutesController < ApplicationController
  def index
    @routes = Route.all
    # The `geocoded` scope filters only flats with coordinates
    @markers = @routes.geocoded.map do |route|
      {
        lat: route.latitude,
        lng: route.longitude
      }
    end
  end
end
