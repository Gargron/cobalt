class AddInboxUrlToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :inbox_url, :string
  end
end
