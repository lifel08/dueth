class AddStateToInstruments < ActiveRecord::Migration[6.1]
  def change
    add_column :instruments, :pause, :boolean, default: false
  end
end
