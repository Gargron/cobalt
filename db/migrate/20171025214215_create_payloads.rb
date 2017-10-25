class CreatePayloads < ActiveRecord::Migration[5.1]
  def change
    create_table :payloads, id: false do |t|
      t.string :id, null: false, default: '', index: { unique: true }
      t.boolean :local, null: false, default: false
      t.jsonb :payload, null: false, default: {}
    end
  end
end
