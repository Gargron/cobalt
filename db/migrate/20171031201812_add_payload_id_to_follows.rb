class AddPayloadIdToFollows < ActiveRecord::Migration[5.1]
  def change
    add_column :follows, :payload_id, :string, null: false, default: ''
    add_foreign_key :follows, :payloads, on_delete: :cascade
  end
end
