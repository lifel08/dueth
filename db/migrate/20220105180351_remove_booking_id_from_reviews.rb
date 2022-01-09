class RemoveBookingIdFromReviews < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :booking_id
  end
end
