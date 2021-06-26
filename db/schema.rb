# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_21_182419) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cars", force: :cascade do |t|
    t.decimal "price"
    t.decimal "cost"
    t.string "model"
    t.integer "year"
    t.string "assembly_line"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "order_changes", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "stock_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_changes_on_order_id"
    t.index ["stock_id"], name: "index_order_changes_on_stock_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "stock_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stock_id"], name: "index_orders_on_stock_id"
  end

  create_table "parts", force: :cascade do |t|
    t.string "name"
    t.boolean "is_defective"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "car_id", null: false
    t.index ["car_id"], name: "index_parts_on_car_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "status"
    t.bigint "car_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["car_id"], name: "index_stocks_on_car_id"
  end

  add_foreign_key "order_changes", "orders", on_delete: :cascade
  add_foreign_key "order_changes", "stocks", on_delete: :cascade
  add_foreign_key "orders", "stocks", on_delete: :cascade
  add_foreign_key "parts", "cars", on_delete: :cascade
  add_foreign_key "stocks", "cars", on_delete: :cascade
end
