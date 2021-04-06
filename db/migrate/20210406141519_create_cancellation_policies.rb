class CreateCancellationPolicies < ActiveRecord::Migration[6.1]
  def change
    create_table :cancellation_policies do |t|
      t.string :name,
      t.datetime :hours

      t.timestamps
    end
  end
end
