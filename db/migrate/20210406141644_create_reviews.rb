class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.string :content
      t.references :user
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end


