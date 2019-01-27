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

ActiveRecord::Schema.define(version: 2019_01_25_132307) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "operator_usages", force: :cascade do |t|
    t.bigint "operator_id"
    t.date "day"
    t.integer "usage", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["operator_id", "day"], name: "index_operator_usages_on_operator_id_and_day", unique: true
    t.index ["operator_id"], name: "index_operator_usages_on_operator_id"
  end

  create_table "operators", force: :cascade do |t|
    t.string "display_sign"
    t.string "action"
    t.string "type"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "operator_usages", "operators"
end
