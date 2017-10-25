# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171025214456) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "display_name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_accounts_on_username", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.bigint "account_id"
    t.string "payload_id", default: "", null: false
    t.index ["account_id", "payload_id"], name: "index_activities_on_account_id_and_payload_id", unique: true
    t.index ["account_id"], name: "index_activities_on_account_id"
  end

  create_table "payloads", id: false, force: :cascade do |t|
    t.string "id", default: "", null: false
    t.boolean "local", default: false, null: false
    t.jsonb "payload", default: {}, null: false
    t.index ["id"], name: "index_payloads_on_id", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.text "file_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id"
    t.boolean "published", default: false, null: false
    t.text "description", default: "", null: false
  end

  add_foreign_key "activities", "accounts", on_delete: :cascade
  add_foreign_key "activities", "payloads", on_delete: :cascade
  add_foreign_key "videos", "accounts", on_delete: :cascade
end
