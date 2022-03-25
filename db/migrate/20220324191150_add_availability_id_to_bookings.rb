class AddAvailabilityIdToBookings < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :availability_id, :integer
  end
end
