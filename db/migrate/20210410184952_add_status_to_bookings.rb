class AddStatusToBookings < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :status, :integer
  end
end
