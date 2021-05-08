class AddAddressToInstrument < ActiveRecord::Migration[6.1]
  def change
    add_column :instruments, :house_number, :string
    add_index :instruments, :house_number
    add_column :instruments, :flat_number, :string
    add_index :instruments, :flat_number
    add_column :instruments, :street_name, :string
    add_index :instruments, :street_name
    add_column :instruments, :district, :string
    add_index :instruments, :district
    add_column :instruments, :postal_code, :string
    add_index :instruments, :postal_code
    add_column :instruments, :city, :string
    add_index :instruments, :city
    add_column :instruments, :country, :string
    add_index :instruments, :country
  end
end
