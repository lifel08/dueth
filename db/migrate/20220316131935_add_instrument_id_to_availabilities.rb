class AddInstrumentIdToAvailabilities < ActiveRecord::Migration[6.1]
  def change
    add_column :availabilities, :instrument_id, :integer
  end
end
