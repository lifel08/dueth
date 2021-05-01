class AddLanguageToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :language, :string, default: 'en'
    add_index :users, :language
  end
end
