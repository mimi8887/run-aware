class RoutesController < ApplicationController
  require 'open-uri'

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
    if @route == Route.last
      @start_address = I18n.transliterate(@route.start_address)
      @end_address = I18n.transliterate(@route.end_address)
      json_start = URI.parse("https://nominatim.openstreetmap.org/search.php?q=#{@start_address}&format=jsonv2").read
      JSON.parse(json_start)
      @start_lat = JSON.parse(json_start)[0]["lat"]
      @start_long = JSON.parse(json_start)[0]["lng"]

      json_end = URI.parse("https://nominatim.openstreetmap.org/search.php?q=#{@end_address}&format=jsonv2").read
      JSON.parse(json_end)
      @end_lat = JSON.parse(json_end)[0]["lat"]
      @end_long = JSON.parse(json_end)[0]["lng"]
      @distance = @route.distance

      client = OpenAI::Client.new
      chatgpt_response = client.chat(parameters: {
        model: "gpt-4o-mini",
        messages: [{ role: "user", content:
        "I am in Berlin Germany and I want to go for a run. I will start at #{@start_lat}, #{@start_long}
        and end at #{@end_lat}, #{@end_long}.
        The run should be approximately #{@distance}. Can you give me 5 waypoints (including the start and end points)
        with latitude and longitude that form a logical, connected route?
        Each point should be roughly equally spaced and follow real-world paths or streets.
        Please ensure the start and end points match the addresses provided.

        The response format should strictly be valid JSON text like this:

         [
            { \"latitude\": LATITUDE_VALUE, \"longitude\": LONGITUDE_VALUE },
            { \"latitude\": LATITUDE_VALUE, \"longitude\": LONGITUDE_VALUE },
            ...
          ]

        Do not add any comments, extra text or ``` in your response. Thank you!" }]
        })
      # @steps = eval(chatgpt_response["choices"][0]["message"]["content"].gsub("\n", "").gsub(" ", ""))

      @json = chatgpt_response["choices"][0]["message"]["content"]
      @steps = JSON.parse(@json)
      p chatgpt_response
      p @json
      p @steps
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
