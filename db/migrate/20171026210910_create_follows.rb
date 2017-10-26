class CreateFollows < ActiveRecord::Migration[5.1]
  def change
    create_table :follows do |t|
      t.bigint :account_id, null: false, default: 0
      t.bigint :target_account_id, null: false, default: 0
    end

    add_foreign_key :follows, :accounts, on_delete: :cascade
    add_foreign_key :follows, :accounts, column: :target_account_id, on_delete: :cascade
  end
end
