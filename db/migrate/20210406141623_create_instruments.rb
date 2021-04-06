class CreateInstruments < ActiveRecord::Migration[6.1]
  def change
    create_table :instruments do |t|
      t.string :title,
      t.string :subtitle,
      t.string :description,
      t.string :location,
      t.decimal, :latitude
      t.decimal, :longitude
      t.references, :cancellation_policy
      t.integer, :price
      t.references :user_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
