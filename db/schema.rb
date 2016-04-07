# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160407222522) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "pg_trgm"

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_filters", force: :cascade do |t|
    t.datetime "start_at_from"
    t.datetime "start_at_to"
    t.integer  "theme_id"
    t.integer  "city_id"
    t.integer  "user_id"
  end

  add_index "event_filters", ["city_id"], name: "index_event_filters_on_city_id", using: :btree
  add_index "event_filters", ["start_at_from"], name: "index_event_filters_on_start_at_from", using: :btree
  add_index "event_filters", ["start_at_to"], name: "index_event_filters_on_start_at_to", using: :btree
  add_index "event_filters", ["theme_id"], name: "index_event_filters_on_theme_id", using: :btree
  add_index "event_filters", ["user_id"], name: "index_event_filters_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.text     "title"
    t.integer  "user_id"
    t.integer  "city_id"
    t.datetime "start_at"
    t.datetime "finish_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
  end

  add_index "events", ["city_id"], name: "index_events_on_city_id", using: :btree
  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "events_themes", id: false, force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "theme_id", null: false
  end

  add_index "events_themes", ["event_id", "theme_id"], name: "index_events_themes_on_event_id_and_theme_id", using: :btree
  add_index "events_themes", ["theme_id", "event_id"], name: "index_events_themes_on_theme_id_and_event_id", using: :btree

  create_table "themes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "event_filters", "cities"
  add_foreign_key "event_filters", "themes"
  add_foreign_key "event_filters", "users"
end
