class CreateInstrumentsAvailabilities < ActiveRecord::Migration[6.1]
  def change
    create_table :instruments_availabilities do |t|
      t.integer :instrument_id
      t.integer :availability_id
      t.string :status

      t.timestamps
    end
  end
end
