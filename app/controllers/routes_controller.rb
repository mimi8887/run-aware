require "open-uri"

class RoutesController < ApplicationController
  require 'open-uri'

  def index
    @routes = Route.all
    @array = []
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
      @start_long = JSON.parse(json_start)[0]["lon"]

      json_end = URI.parse("https://nominatim.openstreetmap.org/search.php?q=#{@end_address}&format=jsonv2").read
      JSON.parse(json_end)
      @end_lat = JSON.parse(json_end)[0]["lat"]
      @end_long = JSON.parse(json_end)[0]["lon"]
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

      @steps.each_with_index do |step, index|
        if index == 0
          step[:marker_html] = render_to_string(partial: "shared/marker")
        else
          step[:marker_html] = render_to_string(partial: "shared/markerarrive")
        end
      end
      @route.steps_as_json = @steps.to_json

      client_name = OpenAI::Client.new
      chatgpt_response_name = client_name.chat(parameters: {
        model: "gpt-4o-mini",
        messages: [{ role: "user", content: "
            I am going on a run.
            Can you please generate a nice name made with 3 words for my run mentionning the name of the neighbourhood in Berlin
            ( Kreuzberg, Neukoelln etc) but not the name of the street of #{@start_address} or #{@end_address}?
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
            Can you please generate a very simple description for my run made with 1 sentence made with maximum 7 words,
            focusing on the neighbourhood (Mitte, Kreuzberg, Neukoelln etc) of #{@start_address} or #{@end_address}?
            Give me only the description of the run, without any of your own answer like 'Here is a nice name for...'.
            thank you!"
            }]
          })
      @route.description = chatgpt_response_description["choices"][0]["message"]["content"]
    else
      @steps = @route.steps.select(:latitude, :longitude).order(:position).as_json
      @steps.each_with_index do |step, index|
        if index == 0
          step[:marker_html] = render_to_string(partial: "shared/marker")
        else
          step[:marker_html] = render_to_string(partial: "shared/markerarrive")
        end
      end
    end
    @route.save
  @route.distance = fake_distance(@route.distance)
  @route.save


    @url = "https://api.openweathermap.org/data/2.5/weather?lat=52.52&lon=13.40&appid=93fad4ed2d411554730316c443c0e0df"
    @json = URI.parse(@url).read
    @data = JSON.parse(@json)
    @temperature = @data['main']['temp']
    @degree = @temperature.to_f - 273.15
    @weather = @data['weather'][0]['main']



    tips_description = OpenAI::Client.new
    chatgpt_response_tips = tips_description.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [{ role: "user", content: "
         I am going on a run.
          Can you please generate two nice tips for runners in Berlin on what they should wear depending on the weather today.
          The tips should be only 1 sentence with maximum 5 words and emojis as index and dont use any number as index please.
          Every tip should be on a different paragraph.
          The temperature is #{@degree} degrees today. Please don't add any comments or extra text from you.
          thank you!"
           }]
        })

    @tips = chatgpt_response_tips["choices"][0]["message"]["content"].gsub("\n", " ").split(/(?=\d+\.\s)/).map(&:strip)
  end

  def create
      @route = Route.new(route_params)
      @route.user = current_user
      @route.save
      redirect_to route_path(@route)
  end

  private

  def fake_distance(selected_distance)
    case selected_distance
    when '5 - 10km'
      rand(5..10)
    when '10 - 15km'
      rand(10..15)
    when '15 - 20km'
      rand(15..20)
    when '20 - 25 km'
      rand(20..25)
    else
      rand(5..25)
    end
  end

  def route_params
    params.require(:route).permit(:start_address, :end_address, :distance)
  end

  def results
    @routes = Route.order("RESULT()").first
  end
end
