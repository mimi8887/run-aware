puts 'destroy all records'
Route.destroy_all
User.destroy_all

user1 = User.create(email: "fernanda@gmail.com", password: "123456")
user2 = User.create(email: "natalia@gmail.com", password: "123456")
user3 = User.create(email: "sinome@gmail.com", password: "123456")

puts 'create routes'

Route.create(name: "Kreuzberg Park Loop", distance: 5,
             description: "A scenic loop through Kreuzberg's lush parks, ideal for a relaxing run on sunny afternoons.",
             user: user1, start_address: "Großbeerenstraße 32", end_address:)
Route.create(name: "Prenzlauer Berg Pathway", distance: 10,
             description: "Explore the charming streets and tree-lined paths of Prenzlauer Berg,
              perfect for crisp autumn mornings.", user: user2)
Route.create(name: "Charlottenburg Canal Run", distance: 25,
             description: "A tranquil route along the canal in Charlottenburg,
              great for peaceful evening jogs by the water", user: user3)
Route.create(name: "Mitte Skyline Sprint", distance: 15,
             description: "Dash through Berlin's vibrant city center with
             views of iconic landmarks—best enjoyed during a clear, breezy day.", user: user1)
Route.create(name: "Tempelhof Track Trail", distance: 5,
             description: "Run on the historic Tempelhof airfield,
               a wide-open route perfect for windy or overcast days.", user: user3)

puts "created #{Route.count} routes"
puts "created #{User.count} user"
