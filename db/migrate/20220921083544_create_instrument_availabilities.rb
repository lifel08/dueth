class CreateInstrumentAvailabilities < ActiveRecord::Migration[6.1]
  def change
    create_table :instrument_availabilities do |t|

      t.references :instrument, null: false, foreign_key: true, index: true 
      t.references :availability, null: false, foreign_key: true, index: true
      t.string :status, default: :Available

      t.timestamps
    end
  end
end
