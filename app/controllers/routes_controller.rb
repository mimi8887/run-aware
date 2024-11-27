class RoutesController < ApplicationController
  def index
    @routes = Route.all
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
