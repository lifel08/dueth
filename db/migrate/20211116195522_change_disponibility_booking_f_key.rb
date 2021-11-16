class ChangeDisponibilityBookingFKey < ActiveRecord::Migration[6.1]
  def up
    change_column :bookings, :disponibility_id, :bigint, null: true, foreign_key: {on_delete: :cascade}
  end

  def down

  end
end
