class AddColumnToBooking < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :day, :string
  end
end
