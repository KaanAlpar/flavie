# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Creating users..."
10.times do
  email = "#{Faker::Name.first_name}#{Faker::Name.last_name}@test.com".downcase
  User.create!(email: email, password: 'test123')
end
puts "...finished creating users"

<<<<<<< HEAD

# make two decks for each users

puts "Creating 2 Decks for each User..."
User.each do |user|
  2.times do
    deck_name = Faker::Educator.degree
    Deck.create!(user: user , name: deck_name)
  end
end
puts "finished creating decks..."


# make 20 conversions (two conversions/each user/one per deck)
puts "Creating 2 Conversions per User..."
ted_talks = [
  "https://www.youtube.com/watch?v=vPAzMG6v46I",
  "https://www.youtube.com/watch?v=azmfraT4-sw",
  "https://www.youtube.com/watch?v=o_XVt5rdpFY",
  "https://www.youtube.com/watch?v=PRF3_M6q7Ng",
  "https://www.youtube.com/watch?v=GYKhOmONWcA",
  "https://www.youtube.com/watch?v=1i9kcBHX2Nw"
]
User.each do |user|
  2.times do
    title = Faker::Quote.yoda
    url = ted_talks.sample
    Conversion.create!(user: user, video_title: title, url: url)
  end
end

puts "finished creating conversions..."



=======
>>>>>>> master
