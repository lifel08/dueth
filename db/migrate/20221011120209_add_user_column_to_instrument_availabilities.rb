class AddUserColumnToInstrumentAvailabilities < ActiveRecord::Migration[6.1]
  def change
    add_column :instrument_availabilities, :user_id, :bigint
  end
end
