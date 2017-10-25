class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.belongs_to :account, foreign_key: { on_delete: :cascade }
      t.string :payload_id, null: false, default: ''
    end

    add_index :activities, [:account_id, :payload_id], unique: true
    add_foreign_key :activities, :payloads, on_delete: :cascade
  end
end
