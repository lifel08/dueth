class AddBirthdayToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :birthday, :datetime
  end
end
