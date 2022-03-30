class CreateInstrumentDisponbilities < ActiveRecord::Migration[6.1]
  def change
    create_table :instrument_disponbilities do |t|
      t.references :user
      t.references :instrument
      t.datetime :start_date
      t.datetime :end_date
      t.string :status
      t.boolean :availability
      t.timestamps
    end
  end
end
