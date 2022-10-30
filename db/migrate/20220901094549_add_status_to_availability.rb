class AddStatusToAvailability < ActiveRecord::Migration[6.1]
  def change
    add_column :availabilities, :status, :string
  end
end
