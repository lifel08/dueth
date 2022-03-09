class AddInstrumentDisponbilityToBookings < ActiveRecord::Migration[6.1]
  def change
    add_reference :bookings, :instrument_disponbility,  foreign_key: true
  end
end
