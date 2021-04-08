class RemoveHoursFromCancellationPolicies < ActiveRecord::Migration[6.1]
  def change
     remove_column :cancellation_policies, :hours, :datetime
  end
end
