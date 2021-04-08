class RemoveDateFromDisponibilities < ActiveRecord::Migration[6.1]
  def change
    remove_column :disponibilities, :date, :date
  end
end
