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

ActiveRecord::Schema.define(version: 20171104073144) do

  create_table "preferences", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "shift"
    t.string "schedule"
    t.integer "user_id"
    t.index ["user_id"], name: "index_preferences_on_user_id"
  end

  create_table "semesters", force: :cascade do |t|
    t.string "semester_name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shift_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "shift_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shift_id"], name: "index_shift_users_on_shift_id"
    t.index ["user_id"], name: "index_shift_users_on_user_id"
  end

  create_table "shifts", force: :cascade do |t|
    t.integer "semester_id"
    t.string "day"
    t.time "time"
    t.string "location"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["semester_id"], name: "index_shifts_on_semester_id"
  end

  create_table "shifts_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "shift_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shift_id"], name: "index_shifts_users_on_shift_id"
    t.index ["user_id"], name: "index_shifts_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "building"
    t.integer "manage"
    t.integer "hours", default: 0
    t.integer "fines", default: 0
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.boolean "init", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
