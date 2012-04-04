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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120404210314) do

  create_table "addresses", :force => true do |t|
    t.string   "address"
    t.integer  "zip_code"
    t.string   "city"
    t.string   "state"
    t.integer  "phone_number"
    t.string   "contact_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "agents", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.text     "website_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "uuid"
    t.boolean  "verified"
    t.string   "outgoing_phone"
    t.string   "outgoing_email"
    t.boolean  "active"
  end

  add_index "agents", ["user_id"], :name => "index_agents_on_user_id"
  add_index "agents", ["uuid"], :name => "index_agents_on_uuid", :unique => true

  create_table "email_notifications", :force => true do |t|
    t.integer  "agent_id"
    t.string   "title"
    t.text     "message"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "email_notifications", ["agent_id"], :name => "index_email_notifications_on_agent_id"

  create_table "email_reminders", :force => true do |t|
    t.integer  "agent_id"
    t.string   "name"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", :force => true do |t|
    t.string   "day"
    t.string   "week"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "notification_type"
  end

  add_index "notifications", ["person_id"], :name => "index_notifications_on_person_id"

  create_table "people", :force => true do |t|
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "phone"
    t.string   "mobile_phone"
    t.integer  "agent_id",     :default => 12
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
  end

  add_index "people", ["agent_id"], :name => "index_people_on_agent_id"
  add_index "people", ["user_id"], :name => "index_people_on_user_id"

  create_table "plans", :force => true do |t|
    t.string   "name"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recordings", :force => true do |t|
    t.integer  "agent_id"
    t.text     "recording_url"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sms_notifications", :force => true do |t|
    t.integer  "agent_id"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active"
  end

  add_index "sms_notifications", ["agent_id"], :name => "index_sms_notifications_on_agent_id"

  create_table "subscriptions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "plan_id"
    t.string   "stripe_customer_token"
    t.string   "stripe_card_token"
    t.string   "email"
    t.integer  "agent_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer  "roles_mask"
    t.string   "account_confirmation"
    t.date     "account_confirmed_at"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

end
