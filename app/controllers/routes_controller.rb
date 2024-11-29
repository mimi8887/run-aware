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
    if @route.steps.any?
      @start_address = @route.start_address
      @end_address = @route.end_address
      client = OpenAI::Client.new
      chatgpt_response = client.chat(parameters: {
        model: "gpt-4o-mini",
        messages: [{ role: "user", content: "hello chat gpt!
          I want to go for a run. I will start at #{@start_address}  and end at #{@end_address}
          Can you please give me 5 points with longitude and latitude that form a route?
          The first should be my starting address and my last point is the ending address.
          please give me back in this format:
            [
              { latitude: LATITUDE_VALUE, longitude: LONGITUDE_VALUE },
              { latitude: LATITUDE_VALUE, longitude: LONGITUDE_VALUE },
              ...]
            All the points should be equally spread from each other.
            and please do not leave any of your comments in your response :)
            thank you!" }]
          })
      @steps = eval(chatgpt_response["choices"][0]["message"]["content"].gsub("\n", "").gsub(" ", ""))
    # JSON.parse(chatgpt_response["choices"][0]["message"]["content"])

      client_name = OpenAI::Client.new
      chatgpt_response_name = client_name.chat(parameters: {
        model: "gpt-4o-mini",
        messages: [{ role: "user", content: "
            I am going on a run.
            Can you please generate a nice name made with 3 words for my run mentionning the name of the neighbourhood
            (Mitte, Kreuzberg, Neukoelln etc) but not the name of the street of #{@start_address} or #{@end_address}?
            Give me only the name of the run, without any of your own answer like 'Here is a nice name for...'.
            thank you!"
            }]
          })
      @route.name = chatgpt_response_name["choices"][0]["message"]["content"]

      client_description = OpenAI::Client.new
      chatgpt_response_description = client_description.chat(parameters: {
        model: "gpt-4o-mini",
        messages: [{ role: "user", content: "
            I am going on a run.
            Can you please generate a very simple description for my run made with 2 sentences,
            focusing on the neighbourhood (Mitte, Kreuzberg, Neukoelln etc) of #{@start_address} or #{@end_address}?
            Give me only the description of the run, without any of your own answer like 'Here is a nice name for...'.
            thank you!"
            }]
          })
      @route.description = chatgpt_response_description["choices"][0]["message"]["content"]
  else
    @steps = @route.steps.select(:latitude, :longitude).order(:position).as_json
  end
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
    @routes = Route.order("RESULT()").first
  end

end
