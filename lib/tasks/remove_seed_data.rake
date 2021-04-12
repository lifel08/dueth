namespace :remove_seed_data do
  desc 'remove seed data'

  task all: :environment do
    puts 'Start removing seed data!'
    CancellationPolicy.delete_all
    Feature.delete_all
    InstrumentFeature.delete_all
    Review.delete_all
    Booking.delete_all
    Instrument.delete_all
    User.delete_all
    puts 'Removing all the data is done!'
  end
end

