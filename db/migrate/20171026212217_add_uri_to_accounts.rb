class AddUriToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :local, :boolean, null: false, default: false
    add_column :accounts, :uri, :string, null: false, default: '', index: { unique: true }

    remove_index :accounts, :username
    add_index :accounts, :username, unique: true, where: 'local = true'
  end
end
