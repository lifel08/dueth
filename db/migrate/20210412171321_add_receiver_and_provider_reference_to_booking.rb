class AddReceiverAndProviderReferenceToBooking < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :receiver_id, :bigint
    add_index :bookings, :receiver_id
    add_column :bookings, :provider_id, :bigint
    add_index :bookings, :provider_id
  end
end
