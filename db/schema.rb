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

ActiveRecord::Schema.define(version: 20150803234446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_logs", force: :cascade do |t|
    t.integer  "action_id",                  null: false
    t.jsonb    "payload"
    t.datetime "last_started_processing_at"
    t.datetime "successfully_processed_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "action_logs", ["action_id"], name: "index_action_logs_on_action_id", using: :btree

  create_table "actions", force: :cascade do |t|
    t.string   "name",           null: false
    t.text     "description"
    t.integer  "operation_id",   null: false
    t.string   "type",           null: false
    t.jsonb    "field_mappings"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "actions", ["operation_id"], name: "index_actions_on_operation_id", using: :btree

  create_table "channels", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "conditions", force: :cascade do |t|
    t.integer  "operation_id",        null: false
    t.string   "operator_field_name", null: false
    t.string   "operator",            null: false
    t.string   "operand_field_name"
    t.string   "operand_value"
    t.string   "data_type",           null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "conditions", ["operation_id"], name: "index_conditions_on_operation_id", using: :btree

  create_table "event_logs", force: :cascade do |t|
    t.integer  "channel_id",                 null: false
    t.string   "type",                       null: false
    t.jsonb    "payload"
    t.datetime "last_started_processing_at"
    t.datetime "successfully_processed_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "event_logs", ["channel_id"], name: "index_event_logs_on_channel_id", using: :btree

  create_table "operations", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "action_logs", "actions"
  add_foreign_key "actions", "operations"
  add_foreign_key "conditions", "operations"
  add_foreign_key "event_logs", "channels"
end
