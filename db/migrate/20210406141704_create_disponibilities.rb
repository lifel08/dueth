class CreateDisponibilities < ActiveRecord::Migration[6.1]
  def change
    create_table :disponibilities do |t|
      t.date, :date
      t.references, :id_instruments
      t.datetime, :from
      t.datetime :to

      t.timestamps
    end
  end
end
