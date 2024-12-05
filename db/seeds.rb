puts 'Destroying all records...'
Bookmark.destroy_all
Step.destroy_all
Run.destroy_all
Route.destroy_all
User.destroy_all

puts 'Creating users...'
user1 = User.create(email: "fernanda@gmail.com", password: "123456")
user2 = User.create(email: "natalia@gmail.com", password: "123456")
user3 = User.create(email: "sinome@gmail.com", password: "123456")

puts 'Creating routes...'
kreuzberg_run = Route.create(
  name: "Kreuzberg Park Loop",
  distance: 5,
  description: "A scenic loop through Kreuzberg's lush parks, ideal for a relaxing run on sunny afternoons.",
  user: user1,
  start_address: "Großbeerenstraße 32",
  end_address: "Hermannstraße 233"
)
puts 'creating steps for kreuzberg'
Step.create(latitude: 52.48578717128562, longitude: 13.38588414869865, position: 0, route: kreuzberg_run)
Step.create(latitude: 52.48293683457218, longitude: 13.394251634598700, position: 1, route: kreuzberg_run)
Step.create(latitude: 52.47263456794273, longitude: 13.401832172346290, position: 1, route: kreuzberg_run)
Step.create(latitude: 52.46783249127386, longitude: 13.386942103478290, position: 1, route: kreuzberg_run)
Step.create(latitude: 52.48773804724967, longitude: 13.383683784580232, position: 1, route: kreuzberg_run)

tiergarden_run = Route.create(
  name: "Tiergarten Scenic Loop ",
  distance: 5,
  description: "A serene route showcasing Tiergarten’s lush greenery, iconic landmarks, and peaceful surroundings",
  user: user3
)

puts 'creating steps for tiergarden'
Step.create(latitude: 52.513474, longitude: 13.338130, position: 0, route: tiergarden_run)
Step.create(latitude: 52.512371, longitude: 13.342762, position: 1, route: tiergarden_run)
Step.create(latitude: 52.512671, longitude: 13.348316, position: 2, route: tiergarden_run)
Step.create(latitude: 52.511654, longitude: 13.360132, position: 3, route: tiergarden_run)
Step.create(latitude: 52.515317, longitude: 13.366153, position: 4, route: tiergarden_run)
Step.create(latitude: 52.516347, longitude: 13.359439, position: 5, route: tiergarden_run)
Step.create(latitude: 52.517318, longitude: 13.348586, position: 6, route: tiergarden_run)
Step.create(latitude: 52.517783, longitude: 13.342369, position: 7, route: tiergarden_run)

puts 'creating run'
Run.create(route: tiergarden_run, user: user2)

prenztlauer_run = Route.create(
  name: "Prenzlauer Berg Pathway",
  distance: 10,
  description: "Explore the charming streets and tree-lined paths of Prenzlauer Berg, perfect for crisp autumn mornings.",
  user: user2
)

charlottenburg_run = Route.create(
  name: "Charlottenburg Canal Run",
  distance: 25,
  description: "A tranquil route along the canal in Charlottenburg, great for peaceful evening jogs by the water.",
  user: user3
)

mitte_run = Route.create(
  name: "Mitte Skyline Sprint",
  distance: 15,
  description: "Dash through Berlin's vibrant city center with views of iconic landmarks—best enjoyed during a clear, breezy day.",
  user: user1
)

tempelhof_run = Route.create(
  name: "Tempelhof Track Trail",
  distance: 5,
  description: "Run on the historic Tempelhof airfield, a wide-open route perfect for windy or overcast days.",
  user: user3
)


puts 'creating bookmark for tiergarten'

tiergarden_bookmark = Bookmark.create(user: user2, route: tiergarden_run)

puts "attaching photos ..."

kreuzberg_run.photo.attach(io: URI.open("https://res.cloudinary.com/dlmjemn37/image/upload/v1733322365/Kreuzberg_Park_Loop_ovm76m.jpg"),
                           filename: "kreuzberg_park_loop.jpg", content_type: "image/jpeg")
prenztlauer_run.photo.attach(io: URI.open("https://res.cloudinary.com/dlmjemn37/image/upload/v1733322364/Prenzlauer_Berg_Pathway_fhebzu.jpg"),
                             filename: "prenztlauer_berg_pathway.jpg", content_type: "image/jpeg")
charlottenburg_run.photo.attach(io: URI.open("https://res.cloudinary.com/dlmjemn37/image/upload/v1733392160/anleger-schlossbruecke_01_jqcpfk.jpg"),
                                filename: "charlottenburg_canal_run.jpg", content_type: "image/jpeg")
mitte_run.photo.attach(io: URI.open("https://res.cloudinary.com/dlmjemn37/image/upload/v1733322367/Mitte_Skyline_Sprint_j6gc7k.jpg"),
                       filename: "mitte_skyline_sprint.jpg", content_type: "image/jpeg")
tempelhof_run.photo.attach(io: URI.open("https://res.cloudinary.com/dlmjemn37/image/upload/v1733322364/Tempelhof_Track_Trail_xm1nst.jpg"),
                           filename: "tempelhof_track_trail.jpg", content_type: "image/jpeg")
tiergarden_run.photo.attach(io: URI.open("https://res.cloudinary.com/dlmjemn37/image/upload/v1733392226/8263201711_ffc2544af5_z-1_ikmqo5.jpg"),
                            filename: "tiergarten_scenic_loop.jpg", content_type: "image/jpeg")
tiergarden_bookmark.photos.attach(io: URI.open("https://res.cloudinary.com/dlmjemn37/image/upload/v1733395473/f28d82ae-f63e-4b6c-9d9f-502aad7dd310_v0yqy0.jpg"),
                                 filename: "tiergarten_scenic_loop.jpg", content_type: "image/jpeg")

puts "Created #{Route.count} routes!"
puts "Created #{User.count} users!"
