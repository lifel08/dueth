class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.references :instrument
      t.references :user
      t.boolean :status
      t.datetime :from
      t.datetime :to

      t.timestamps
    end
  end
end
