class ChangeColumnHoursDatetimeToHoursInteger < ActiveRecord::Migration[6.1]
  def change
    change_column :cancellation_policies, :hours, :integer, using: 'hours::integer'
  end
end
