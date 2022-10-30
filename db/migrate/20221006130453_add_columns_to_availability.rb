class AddColumnsToAvailability < ActiveRecord::Migration[6.1]
  def change
    add_column :availabilities, :start_datetime, :datetime
    add_column :availabilities, :end_datetime, :datetime
  end
end
