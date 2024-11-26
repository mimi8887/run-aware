# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts 'destroy all records'
Route.destroy_all

puts 'create steps'

Step.create(longitude: )

puts 'create routes'

Route.create(name: "Kreuzberg Park Loop", distance: 5, address: "Großbeerenstraße 32, 10965 Berlin",
             description: "A scenic loop through Kreuzberg’s lush parks, ideal for a relaxing run on sunny afternoons.")
Route.create(name: "Prenzlauer Berg Pathway", distance: 10, address: "Kollwitzstraße 65, 10435 Berlin",
             description: "Explore the charming streets and tree-lined paths of Prenzlauer Berg,
              perfect for crisp autumn mornings.")
Route.create(name: "Charlottenburg Canal Run", distance: 25, address: "Spandauer Damm 20-24, 14059 Berlin",
             description: "A tranquil route along the canal in Charlottenburg,
              great for peaceful evening jogs by the water")
Route.create(name: "Mitte Skyline Sprint", distance: 15, address: "Alexanderplatz 1, 10178 Berlin",
             description: "Dash through Berlin’s vibrant city center with
             views of iconic landmarks—best enjoyed during a clear, breezy day.")
Route.create(name: "Tempelhof Track Trail", distance: 5, address: "Columbiadamm 84, 10965 Berlin",
             description: "Run on the historic Tempelhof airfield,
               a wide-open route perfect for windy or overcast days.")

puts "created #{Route.count} routes"
