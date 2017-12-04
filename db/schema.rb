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

ActiveRecord::Schema.define(version: 20171130232120) do

  create_table "markets", force: :cascade do |t|
    t.string "username"
    t.string "shift"
    t.boolean "be_taken"
    t.string "taker_username"
  end

  create_table "policies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "filename"
  end

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

  create_table "semesters_shift_templates", force: :cascade do |t|
    t.integer "shift_template_id"
    t.integer "semester_id"
    t.index ["semester_id"], name: "index_semesters_shift_templates_on_semester_id"
    t.index ["shift_template_id"], name: "index_semesters_shift_templates_on_shift_template_id"
  end

  create_table "shift_details", force: :cascade do |t|
    t.string "location"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shift_templates", force: :cascade do |t|
    t.string "floor"
    t.string "details"
    t.integer "hours"
    t.string "day"
    t.string "time"
    t.integer "shift_detail_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shift_detail_id"], name: "index_shift_templates_on_shift_detail_id"
    t.index ["user_id"], name: "index_shift_templates_on_user_id"
  end

  create_table "shifts", force: :cascade do |t|
    t.datetime "date"
    t.boolean "is_checked_off"
    t.integer "checked_off_by"
    t.integer "shift_template_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shift_template_id"], name: "index_shifts_on_shift_template_id"
    t.index ["user_id"], name: "index_shifts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "building"
    t.string "role", default: "User"
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
