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
User.destroy_all

user1 = User.create(email: "fernanda@gmail.com", password: "123456")
user2 = User.create(email: "natalia@gmail.com", password: "123456")
user3 = User.create(email: "sinome@gmail.com", password: "123456")

<<<<<<< HEAD
Step.create(longitude: 13.3958819, latitude: 52.5191864, position: 0, route: kreuzberg)
Step.create(longitude: 13.3958819, latitude: 52.5191864, position: 0, route: kreuzberg)
Step.create(longitude: 13.3958819, latitude: 52.5191864, position: 0, route: kreuzberg)
Step.create(longitude: 13.3958819, latitude: 52.5191864, position: 0, route: kreuzberg)
=======
>>>>>>> 6f800b65ef1bdc72c8109f36c6083f2e6545c43b

puts 'create routes'

Route.create(name: "Kreuzberg Park Loop", distance: 5,
<<<<<<< HEAD
                         description: "A scenic loop through Kreuzberg’s lush parks,
                         ideal for a relaxing run on sunny afternoons.")
Route.create(name: "Prenzlauer Berg Pathway", distance: 10,
             description: "Explore the charming streets and tree-lined paths of Prenzlauer Berg,
              perfect for crisp autumn mornings.")
Route.create(name: "Charlottenburg Canal Run", distance: 25,
             description: "A tranquil route along the canal in Charlottenburg,
              great for peaceful evening jogs by the water")
Route.create(name: "Mitte Skyline Sprint", distance: 15,
             description: "Dash through Berlin’s vibrant city center with
             views of iconic landmarks—best enjoyed during a clear, breezy day.")
=======
             description: "A scenic loop through Kreuzberg’s lush parks, ideal for a relaxing run on sunny afternoons.",
            user: user1)
Route.create(name: "Prenzlauer Berg Pathway", distance: 10,
             description: "Explore the charming streets and tree-lined paths of Prenzlauer Berg,
              perfect for crisp autumn mornings.", user: user2)
Route.create(name: "Charlottenburg Canal Run", distance: 25,
             description: "A tranquil route along the canal in Charlottenburg,
              great for peaceful evening jogs by the water", user: user3)
Route.create(name: "Mitte Skyline Sprint", distance: 15,
             description: "Dash through Berlin’s vibrant city center with
             views of iconic landmarks—best enjoyed during a clear, breezy day.", user: user1)
>>>>>>> 6f800b65ef1bdc72c8109f36c6083f2e6545c43b
Route.create(name: "Tempelhof Track Trail", distance: 5,
             description: "Run on the historic Tempelhof airfield,
               a wide-open route perfect for windy or overcast days.", user: user3)

puts "created #{Route.count} routes"
puts "created #{User.count} user"
