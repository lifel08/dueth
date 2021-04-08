class AddHoursToCancellationPolicies < ActiveRecord::Migration[6.1]
  def change
    add_column :cancellation_policies, :hours, :integer
  end
end
