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

ActiveRecord::Schema.define(version: 20140614151422) do

  create_table "snipps", force: true do |t|
    t.string   "title"
    t.text     "html_code"
    t.text     "css_code"
    t.text     "js_code"
    t.integer  "user_id"
    t.boolean  "published",  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "users", force: true do |t|
    t.string   "nickname",               default: "",    null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "avatar_url"
    t.string   "provider"
    t.string   "uid"
    t.boolean  "admin",                  default: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["nickname"], name: "index_users_on_nickname", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "visit_details", force: true do |t|
    t.integer  "visit_id"
    t.string   "ip_address", limit: 15
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "visit_details", ["ip_address"], name: "index_visit_details_on_ip_address"
  add_index "visit_details", ["visit_id"], name: "index_visit_details_on_visit_id"

  create_table "visits", force: true do |t|
    t.integer  "visitable_id"
    t.string   "visitable_type", limit: 30
    t.integer  "total_visits"
    t.integer  "unique_visits"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "visits", ["visitable_id"], name: "index_visits_on_visitable_id"
  add_index "visits", ["visitable_type"], name: "index_visits_on_visitable_type"

end
