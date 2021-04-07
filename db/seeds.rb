# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "open-uri"
puts 'Start seeding .... 😬'

User.destroy_all
Instrument.destroy_all
Booking.destroy_all

#User Piano Owner
chloe = User.new(
      first_name: 'Chloé',
      last_name: 'Durand',
      email: 'chloe@gmail.com',
      birthday: '12/11/89',
      password: 'password',
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
      birthday: '12/11/72',
      password: 'password',
    )
nam.photo.attach(
            io: URI.open('https://cdn.xl.thumbs.canstockphoto.com/asian-playing-piano-a-shot-of-an-asian-man-playing-piano-stock-image_csp1567046.jpg'),
            filename: 'nam.jpg',
            content_type: 'nam/jpg')
nam.save!

#User Practise Seeker
lucy = User.new(
      first_name: 'Lucy',
      last_name: 'Smith',
      email: 'lucy@gmail.com',
      birthday: '12/11/95',
      password: 'password',
    )
lucy.photo.attach(
            io: URI.open('https://static.roland.com/promos/starting_piano/faq_affordable_piano.jpg'),
            filename: 'lucy.jpg',
            content_type: 'image/jpg')
lucy.save!

puts 'Users seed done! 💪'

# Generate Instrument Instances

acoustic_piano = Piano.new(
                 title: 'Acousting Piano Paris 10e - Beautiful & Stylish',
                 subtitle: 'Chloé is offering her beautiful tuned Yamaha Acoustic Piano for practise ' ,
                 location: '18, Rue de Saint-Quentin, Paris, France',
                 latitude: 48.878125,
                 longitude: 2.355338,
                 cancellation_policy: '2 hours before practise',
                 price: 20 ,
                 user: 1,
  )
acoustic_piano.photo.attach(
            io: URI.open('https://i.pinimg.com/originals/01/bc/4d/01bc4d9bb870b82465bbb1e7d839bbc3.jpg'),
            filename: 'acoustic_piano.jpg',
            content_type: 'image/jpg')
acoustic_piano.save!

digital_piano = Piano.new(
                 title: 'Digital Piano Paris 10e - Calme',
                 subtitle: 'Enjoy a good piano practise in a very quiet area',
                 location: '80 Boulevard de Magenta, Paris, France',
                 latitude: 48.87617675877308,
                 longitude: 2.3566307396897184,
                 cancellation_policy: '1 day before practise',
                 price: 15,
                 user: 2,
  )
digital_piano.photo.attach(
            io: URI.open('http://www.vend-appartement-paris.fr/wp-content/uploads/2018/08/hautpoul-s%C3%A9jour-2.jpg'),
            filename: 'digital_piano.jpg',
            content_type: 'image/jpg')
digital_piano.save!

puts 'Instrument seeds done! 💪'

# Generate Booking Instances

puts 'Seed comlpeted! 🌱'

