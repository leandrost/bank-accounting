# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_29_221412) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "balance", precision: 18, scale: 2, default: "0.0", null: false
  end

  create_table "transfers", force: :cascade do |t|
    t.bigint "source_account_id"
    t.bigint "destination_account_id"
    t.decimal "amount", precision: 18, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["destination_account_id"], name: "index_transfers_on_destination_account_id"
    t.index ["source_account_id"], name: "index_transfers_on_source_account_id"
  end

  add_foreign_key "transfers", "accounts", column: "destination_account_id"
  add_foreign_key "transfers", "accounts", column: "source_account_id"
end
