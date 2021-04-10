class AddInstrumentRefToReviews < ActiveRecord::Migration[6.1]
  def change
    add_reference :reviews, :instrument, null: false, foreign_key: true
  end
end
