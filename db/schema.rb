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

ActiveRecord::Schema.define(version: 2020_10_27_074243) do

  create_table "apps", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.string "image"
    t.string "backgroundColor"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "textcolor"
  end

  create_table "cities", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "kind"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "districts", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "kind"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "city_id"
    t.index ["city_id"], name: "index_districts_on_city_id"
  end

  create_table "houses", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "distric"
    t.string "ward"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "city_id", null: false
    t.integer "district_id", null: false
    t.integer "ward_id", null: false
    t.index ["city_id"], name: "index_houses_on_city_id"
    t.index ["district_id"], name: "index_houses_on_district_id"
    t.index ["ward_id"], name: "index_houses_on_ward_id"
  end

  create_table "infor_servs", force: :cascade do |t|
    t.integer "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "information_id"
    t.integer "service_id"
    t.index ["information_id"], name: "index_infor_servs_on_information_id"
    t.index ["service_id"], name: "index_infor_servs_on_service_id"
  end

  create_table "information", force: :cascade do |t|
    t.string "name"
    t.boolean "sex"
    t.date "birth"
    t.string "indentifycard"
    t.date "daterange"
    t.string "placerange"
    t.string "phone1"
    t.string "phone2"
    t.string "permanent"
    t.date "start"
    t.float "deposit"
    t.text "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.integer "mark", default: 0
  end

  create_table "members", force: :cascade do |t|
    t.json "name"
    t.json "sex"
    t.json "indentifycard"
    t.json "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.json "address"
    t.integer "information_id"
    t.json "birth"
    t.index ["information_id"], name: "index_members_on_information_id"
  end

  create_table "paytherents", force: :cascade do |t|
    t.string "senddate"
    t.string "receivedate"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "information_id"
    t.float "money", default: 0.0
    t.index ["information_id"], name: "index_paytherents_on_information_id"
  end

  create_table "regulations", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "house_id"
    t.index ["house_id"], name: "index_regulations_on_house_id"
  end

  create_table "reminders", force: :cascade do |t|
    t.text "content"
    t.date "start_time"
    t.date "end_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
    t.integer "mark", default: 0
    t.integer "user_id"
    t.index ["user_id"], name: "index_reminders_on_user_id"
  end

  create_table "reports", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.text "rep_content"
    t.integer "mark", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "information_id"
    t.integer "user_id"
    t.integer "house_id"
    t.index ["information_id"], name: "index_reports_on_information_id"
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.string "cost"
    t.string "length"
    t.string "width"
    t.integer "amount"
    t.integer "allow"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "house_id", null: false
    t.string "picture"
    t.integer "information_id"
    t.integer "mark", default: 0
    t.float "oldelectric"
    t.float "newelectric"
    t.float "oldwater"
    t.float "newwater"
    t.index ["house_id"], name: "index_rooms_on_house_id"
    t.index ["information_id"], name: "index_rooms_on_information_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.string "cost"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
  end

  create_table "supports", force: :cascade do |t|
    t.integer "status", default: 0
    t.integer "voice", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "use_services", force: :cascade do |t|
    t.json "service_id"
    t.json "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "information_id", null: false
    t.index ["information_id"], name: "index_use_services_on_information_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "disable", default: 0
    t.integer "admin", default: 0
    t.integer "house_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["house_id"], name: "index_users_on_house_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wards", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "kind"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "district_id"
    t.index ["district_id"], name: "index_wards_on_district_id"
  end

  add_foreign_key "districts", "cities"
  add_foreign_key "houses", "cities"
  add_foreign_key "houses", "districts"
  add_foreign_key "houses", "wards"
  add_foreign_key "infor_servs", "information"
  add_foreign_key "infor_servs", "services"
  add_foreign_key "members", "information"
  add_foreign_key "paytherents", "information"
  add_foreign_key "regulations", "houses"
  add_foreign_key "reminders", "users"
  add_foreign_key "reports", "information"
  add_foreign_key "reports", "users"
  add_foreign_key "rooms", "houses"
  add_foreign_key "rooms", "information"
  add_foreign_key "use_services", "information"
  add_foreign_key "users", "houses"
  add_foreign_key "wards", "districts"
end
