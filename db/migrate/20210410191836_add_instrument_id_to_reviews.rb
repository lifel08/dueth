class AddInstrumentIdToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :instrument, :bigint
  end
end
