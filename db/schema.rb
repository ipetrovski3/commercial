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

ActiveRecord::Schema[7.0].define(version: 2023_01_03_155859) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_brands_on_category_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "cat_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone"
    t.string "edb"
    t.string "emb"
    t.string "due"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "customer_type", default: 0
    t.string "email"
  end

  create_table "documented_products", force: :cascade do |t|
    t.string "documentable_type"
    t.integer "documentable_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "qty"
    t.float "price"
    t.float "total_price"
    t.index ["product_id"], name: "index_documented_products_on_product_id"
  end

  create_table "hotels", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.string "car_model"
    t.string "licence_plate"
    t.boolean "with_wheels"
    t.date "date_in"
    t.date "date_out"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_hotels_on_customer_id"
  end

  create_table "incoming_invoices", force: :cascade do |t|
    t.bigint "customer_id"
    t.integer "number"
    t.date "date"
    t.float "net_price"
    t.float "vat"
    t.float "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_incoming_invoices_on_customer_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "customer_id"
    t.integer "number"
    t.date "date"
    t.float "net_price"
    t.float "vat"
    t.float "total_price"
    t.string "received_by"
    t.string "licence_plate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "due_days", default: 0
    t.index ["customer_id"], name: "index_invoices_on_customer_id"
  end

  create_table "issue_slips", force: :cascade do |t|
    t.integer "number"
    t.date "date"
    t.bigint "customer_id", null: false
    t.string "received_by"
    t.string "licence_plate"
    t.integer "invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_issue_slips_on_customer_id"
  end

  create_table "patterns", force: :cascade do |t|
    t.string "name"
    t.integer "season"
    t.bigint "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_patterns_on_brand_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "dimension"
    t.string "name"
    t.string "code"
    t.string "location"
    t.integer "stock", default: 0
    t.string "retail_price"
    t.bigint "pattern_id"
    t.integer "vat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pattern_id"], name: "index_products_on_pattern_id"
  end

  create_table "tire_dimensions", force: :cascade do |t|
    t.string "dimension"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tire_hotels", force: :cascade do |t|
    t.bigint "hotel_id", null: false
    t.string "tire"
    t.integer "qty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_id"], name: "index_tire_hotels_on_hotel_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "brands", "categories"
  add_foreign_key "documented_products", "products"
  add_foreign_key "hotels", "customers"
  add_foreign_key "incoming_invoices", "customers"
  add_foreign_key "invoices", "customers"
  add_foreign_key "issue_slips", "customers"
  add_foreign_key "patterns", "brands"
  add_foreign_key "products", "patterns"
  add_foreign_key "tire_hotels", "hotels"
end
