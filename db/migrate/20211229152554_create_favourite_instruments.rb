class CreateFavouriteInstruments < ActiveRecord::Migration[6.1]
  def change
    create_table :favourite_instruments do |t|
      t.references :user
      t.references :instrument
      t.timestamps
    end
  end
end
