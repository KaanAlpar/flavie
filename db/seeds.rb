# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

######################################
#### THE SEED DOESN'T WORK ###########
######################################
# puts "Creating users..."
# 10.times do
#   email = "#{Faker::Name.first_name}#{Faker::Name.last_name}@test.com".downcase
#   User.create!(email: email, password: 'test123')
# end
# puts "...finished creating users"

# # make two decks for each users

# puts "Creating 2 Decks for each User..."
# User.all.each do |user|
#   2.times do
#     deck_name = Faker::Educator.degree
#     Deck.create!(user: user , name: deck_name)
#   end
# end
# puts "finished creating decks..."


# # make 20 conversions (two conversions/each user/one per deck)
# puts "Creating 2 Conversions per User..."
# ted_talks = [
#   "https://www.youtube.com/watch?v=o_XVt5rdpFY",
#   "https://www.youtube.com/watch?v=1i9kcBHX2Nw",
#   "https://www.youtube.com/watch?v=KM4Xe6Dlp0Y",
#   "https://www.youtube.com/watch?v=5MgBikgcWnY",
#   "https://www.youtube.com/watch?v=Ge7c7otG2mk",
#   "https://www.youtube.com/watch?v=Bp2Fvkt-TRM",
#   "https://www.youtube.com/watch?v=iBMfg4WkKL8",
# ]
# User.all.each do |user|
#   2.times do
#     video_id = CGI::parse(URI(ted_talks.sample).query)["v"].first
#     video_info = FetchVideoInfoService.call_api(video_id)
#     Conversion.create!(user: user, video_title: video_info[:title], video_id: video_id)
#   end
# end

# puts "finished creating conversions..."
