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

ActiveRecord::Schema.define(version: 2020_07_27_151139) do

  create_table "cities", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "kind"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

# Could not dump table "information" because of following StandardError
#   Unknown type 'bool' for column 'mark'

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
    t.index ["house_id"], name: "index_rooms_on_house_id"
    t.index ["information_id"], name: "index_rooms_on_information_id"
  end

# Could not dump table "services" because of following StandardError
#   Unknown type 'bool' for column 'status'

  create_table "use_services", force: :cascade do |t|
    t.json "service_id"
    t.json "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "information_id", null: false
    t.index ["information_id"], name: "index_use_services_on_information_id"
  end

# Could not dump table "users" because of following StandardError
#   Unknown type '' for column 'admin'

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
  add_foreign_key "rooms", "houses"
  add_foreign_key "rooms", "information"
  add_foreign_key "use_services", "information"
  add_foreign_key "wards", "districts"
end
