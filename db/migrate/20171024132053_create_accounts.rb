class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :username, null: false, default: '', index: { unique: true }
      t.string :display_name, null: false, default: ''

      t.timestamps
    end

    add_column :videos, :account_id, :bigint
    add_foreign_key :videos, :accounts, on_delete: :cascade
  end
end
