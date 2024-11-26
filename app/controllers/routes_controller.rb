class RoutesController < ApplicationController
  def index
    @routes = Route.all
  end

  def new
    @route = Route.new
  end

  def create
      @route = Route.new(route_params)
      @route.user = current_user
      @route.save
    raise
      redirect_to routes_path
  end

  private

  def route_params
    params.require(:route).permit(:name, :description)
  end
end
