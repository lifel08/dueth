# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "open-uri"
puts 'Start seeding .... 😬'

# Destroy at the beginning will not delete


#User Provider (Piano Owner)
chloe = User.new(
  first_name: 'Chloé',
  last_name: 'Durand',
  email: 'chloe@gmail.com',
  birthday: '12/11/1989',
  password: 'password',
  language: 'English, French',
  description: 'I just started playing the piano recently. And I amm travelling a lot and I am happy to practise whereever I go.'
)
chloe.photo.attach(
  io: URI.open('https://cdn.psychologytoday.com/sites/default/files/field_blog_entry_images/2021-01/levi-williams-to5wnmst6qq-unsplash.jpg'),
  filename: 'chloe.jpg',
content_type: 'image/jpg')
chloe.save!

nam = User.new(
  first_name: 'Nam',
  last_name: 'Nguyen',
  email: 'nam@gmail.com',
  birthday: '12/11/1972',
  password: 'password',
  language: 'English, Chinese',
)
nam.photo.attach(
  io: URI.open('https://cdn.xl.thumbs.canstockphoto.com/asian-playing-piano-a-shot-of-an-asian-man-playing-piano-stock-image_csp1567046.jpg'),
  filename: 'nam.jpg',
content_type: 'nam/jpg')
nam.save!

#User Receiver (Practise Seeker)
lucy = User.new(
  first_name: 'Lucy',
  last_name: 'Smith',
  email: 'lucy@gmail.com',
  birthday: '12/11/1995',
  password: 'password',
  language: 'Bangla',
)
lucy.photo.attach(
  io: URI.open('https://static.roland.com/promos/starting_piano/faq_affordable_piano.jpg'),
  filename: 'lucy.jpg',
content_type: 'image/jpg')
lucy.save!

puts 'Users seed done! 💪'

# Generate Cancellation Policy
cancellation_policies = {
  '2 hours before practise' => 2,
  '6 hours before practise' => 6,
  '8 hours before practise' => 8,
  '12 hours before practise' => 12,
  '16 hours before practise' => 16,
  '1 day before practise' => 24,
  '2 days before practise' => 48,
  '3 days before practise' => 62,
  '5 days before practise' => 120
}

cancellation_policies.each do |policy, hour|
  CancellationPolicy.create!(
    name: policy,
    hours: hour
  )
end

puts 'CancellationPolicy seed done! 💪'

# Generate Instrument Instances
acoustic_piano = Instrument.new(
  title: 'Acoustic Piano',
  subtitle: 'Chloé is offering her beautiful tuned Yamaha Acoustic Piano for practise ' ,
  description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  street_name: 'Passage Dubail',
  house_number: '14',
  postal_code: '75010',
  city: 'Paris',
  country: 'France',
  price: 20,
  user: chloe,
  cancellation_policy: cancellation_policies[0]
)
acoustic_piano.photo.attach(
  io: URI.open('https://i.pinimg.com/originals/01/bc/4d/01bc4d9bb870b82465bbb1e7d839bbc3.jpg'),
  filename: 'acoustic_piano.jpg',
content_type: 'image/jpg')
acoustic_piano.save!

digital_piano = Instrument.new(
  title: 'Digital Piano',
  subtitle: 'Enjoy a good piano practise in a very quiet area',
  description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  street_name: 'Via Borgospesso',
  house_number: '15A',
  postal_code: '20121',
  city: 'Milan',
  country: 'Italy',
  price: 15,
  user: nam,
  cancellation_policy: cancellation_policies[5]
)
digital_piano.photo.attach(
  io: URI.open('http://www.vend-appartement-paris.fr/wp-content/uploads/2018/08/hautpoul-s%C3%A9jour-2.jpg'),
  filename: 'digital_piano.jpg',
content_type: 'image/jpg')
digital_piano.save!

puts 'Instrument seeds done! 💪'

# Features

features = {
  "Special Instrument" => '<i class="fas fa-award fa-lg"></i>',
  "Very Quiet Area" => '<i class="fas fa-dove fa-lg"></i>',
  "Tuned" => '<i class="fas fa-music fa-lg"></i>',
  "Instant Booking" => '<i class="fas fa-stopwatch-20 fa-lg"></i>',
  "Close to Public Transport" => '<i class="fas fa-bus fa-lg"></i>',
  "Exceptional View" => '<i class="fas fa-binoculars fa-lg"></i>',
  "Separate Practise Room" => '<i class="fas fa-door-closed fa-lg"></i>',
  "Practise after 9pm" => '<i class="fas fa-cloud-moon fa-lg"></i>'
}

puts 'Features seed done! 💪'

features.each do |feature, icon|
  Feature.create!(
    name: feature,
    icon: icon
  )
end

puts 'Features seeds done! 💪'

# Disponibilites
# monday_morning = Disponibility.new(
#   from: '09:26/6/7/2022',
#   to: '10:26/6/7/2022',
#   instrument: digital_piano
#   )
# monday_morning.save!

# tuesday_afternoon = Disponibility.new(
#   from: '16:26/7/7/2022',
#   to: '17:26/7/7/2022',
#   instrument: acoustic_piano
#   )
# tuesday_afternoon.save!

# puts 'Disponibility seed done! 💪'

# Generate Booking Instances
booking_new = Booking.new(
  instrument: acoustic_piano,
  receiver: lucy,
  provider: acoustic_piano.user,
  status: 'accepted',
  from: '09:26/6/7/2021',
  to: '10:26/6/7/2021'
)

booking_old = Booking.new(
  instrument: acoustic_piano,
  receiver: nam,
  provider: acoustic_piano.user,
  status: 'accepted',
  from: '09:26/6/7/2020',
  to: '10:26/6/7/2020'
)

booking_new.save!
booking_old.save!

puts 'Booking seeds done! 💪'

# Reviews

review1 = Review.new(
  booking: booking_old,
  rating: 5,
  content: 'amazing instrument',
  created_at: Time.now,
  instrument: acoustic_piano,
  user: nam
)
review1.save!

puts 'Review seeds done! 💪'
puts 'Seed completed! 🌱'
