class CreateAvailabilities < ActiveRecord::Migration[6.1]
  def change
    create_table :availabilities do |t|
      t.string :to
      t.string :from
      t.string :day
      t.boolean :available, :default => false
      t.timestamps
    end
  end
end
