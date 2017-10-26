class AddKeyToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :key, :text, null: false, default: ''
  end
end
