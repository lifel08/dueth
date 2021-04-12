class ChangeColumnHoursDatetimeToHoursInteger < ActiveRecord::Migration[6.1]
  def change
    remove_column :cancellation_policies, :hours
    add_column :cancellation_policies, :hours, :integer
  end
end
