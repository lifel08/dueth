class CreateInstrumentFeatures < ActiveRecord::Migration[6.1]
  def change
    create_table :instrument_features do |t|
      t.references :feature
      t.references :instrument, null: false, foreign_key: true

      t.timestamps
    end
  end
end
