class RoutesController < ApplicationController
  def index
    @routes = Route.all
    @markers = [
      { lat: 52.48773804724966, lng: 13.383683784580231 },
      { lat: 52.486351472937, lng: 13.389951169490814 },
      { lat: 52.481837907201206, lng: 13.395120670145922 },
      { lat: 52.47744842474273, lng: 13.400204121177599 },
      { lat: 52.47180112114213, lng: 13.399752206313258 },
      { lat: 52.46844896928392, lng: 13.394121190369173 },
      { lat: 52.47068324803367, lng: 13.387429690144542 },
      { lat: 52.47542334706799, lng: 13.380502925276214 },
      { lat: 52.48280001108698, lng: 13.379095245741312 },
      { lat: 52.48773804724966, lng: 13.383683784580231 }
      ]
  end

  def new
    @route = Route.new
  end

  def show
    @route = Route.find(params[:id])
    @start_address = @route.start_address
    @end_address = @route.end_address
    @steps = @route.steps.select(:latitude, :longitude).order(:position).as_json
  end

  def create
      @route = Route.new(route_params)
      @route.user = current_user
      @route.save
      redirect_to routes_path
  end

  private

  def route_params
    params.require(:route).permit(:start_address, :end_address)
  end

  def results
    results@routes= Route.order("RESULT()").first
  end

end
