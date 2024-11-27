class RoutesController < ApplicationController
  def index
    @routes = Route.all
    @markers = [
      { lat: 52.493325, lng: 13.383275 },
      { lat: 52.482100, lng: 13.393700 },
      { lat: 52.487800, lng: 13.416800 },
      { lat: 52.500500, lng: 13.405200 },
      { lat: 52.493325, lng: 13.383275 }
    ]
  end

  def new
    @route = Route.new
  end

  def show
    @route = Route.find(params[:id])
  end

  def create
      @route = Route.new(route_params)
      @route.user = current_user
      @route.save
      redirect_to routes_path
  end

  private

  def route_params
    params.require(:route).permit(:name, :description)
  end

  def results
    results@routes= Route.order("RESULT()").first
  end

end
