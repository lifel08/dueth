class AddIconToFeatureTable < ActiveRecord::Migration[6.1]
  def change
    add_column :features, :icon, :string
  end
end
