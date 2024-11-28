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
    # @steps = @route.steps.select(:latitude, :longitude).order(:position).as_json
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [{ role: "user", content: "hello chat gpt!
          I want to go for a run. I will start at #{@start_address}  and end at #{@end_address}
          Can you please give me 5 points with longitude and latitude that form a route?
          The first and last points should be my starting/ending address.
          please give me back in this format:
      [
      { latitude: 52.48773804724966, longitude: 13.383683784580231 },
      { latitude: 52.486351472937, longitude: 13.389951169490814 },
        ...]
          and please do not leave any of your comments in your response :)
          thank you!" }]
        })
    @steps = eval(chatgpt_response["choices"][0]["message"]["content"].gsub("\n", "").gsub(" ", ""))
  end

  def create
      @route = Route.new(route_params)
      @route.user = current_user
      @route.save
      redirect_to route_path(@route)
  end

  private

  def route_params
    params.require(:route).permit(:start_address, :end_address)
  end

  def results
    results@routes= Route.order("RESULT()").first
  end

end
