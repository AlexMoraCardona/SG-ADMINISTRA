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

ActiveRecord::Schema[7.0].define(version: 2024_02_23_180759) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer "state", default: 0
    t.string "observation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "calendar_id"
    t.bigint "square_id"
    t.bigint "place_id"
    t.index ["calendar_id"], name: "index_activities_on_calendar_id"
    t.index ["place_id"], name: "index_activities_on_place_id"
    t.index ["square_id"], name: "index_activities_on_square_id"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "adm_calendars", force: :cascade do |t|
    t.integer "year", default: 1900
    t.integer "bisiesto", default: 0
    t.integer "day_initial", default: 1
    t.integer "generated", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "generatedactivities", default: 0
  end

  create_table "calendars", force: :cascade do |t|
    t.integer "day", default: 1
    t.integer "month", default: 1
    t.integer "year", default: 1900
    t.string "name_day"
    t.integer "day_vigente", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "adm_calendar_id"
    t.index ["adm_calendar_id"], name: "index_calendars_on_adm_calendar_id"
  end

  create_table "levels", force: :cascade do |t|
    t.integer "state", default: 0
    t.integer "level_user", default: 0
    t.integer "restriction", default: 0
    t.integer "restriction_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "places", force: :cascade do |t|
    t.integer "state"
    t.string "place_reserva"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "squares", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "state", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "nro_document"
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.integer "state"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "level_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["level_id"], name: "index_users_on_level_id"
    t.index ["nro_document"], name: "index_users_on_nro_document", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "activities", "calendars"
  add_foreign_key "activities", "places"
  add_foreign_key "activities", "squares"
  add_foreign_key "activities", "users"
  add_foreign_key "calendars", "adm_calendars"
  add_foreign_key "users", "levels"
end
