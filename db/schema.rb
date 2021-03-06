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

ActiveRecord::Schema.define(:version => 20120725212441) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "extra"
    t.text     "token"
  end

  create_table "deals", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image_url"
    t.datetime "end_time"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "error_logs", :force => true do |t|
    t.string   "user_agent"
    t.string   "message"
    t.string   "file"
    t.integer  "line"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "games", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "slug"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "prizes", :force => true do |t|
    t.string   "title"
    t.string   "sub_title"
    t.string   "url"
    t.decimal  "price",         :precision => 8, :scale => 2
    t.decimal  "reduced_price", :precision => 8, :scale => 2
    t.integer  "deal_id"
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.integer  "position",                                    :default => 0
  end

  add_index "prizes", ["deal_id"], :name => "index_prizes_on_deal_id"

  create_table "rounds", :force => true do |t|
    t.integer  "user_id"
    t.float    "total_score", :default => 0.0
    t.integer  "step",        :default => 1
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "complete",    :default => false
  end

  create_table "scores", :force => true do |t|
    t.integer  "round_id"
    t.integer  "game_id"
    t.float    "score",      :default => 0.0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.text     "data"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "authentication_token"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "username"
    t.string   "country"
    t.boolean  "admin",                  :default => false
    t.boolean  "opt_in",                 :default => false
    t.string   "first_name"
    t.string   "last_name"
    t.float    "max_score",              :default => 0.0
    t.integer  "plays",                  :default => 0
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["max_score"], :name => "index_users_on_max_score", :order => {"max_score"=>:desc}
  add_index "users", ["plays"], :name => "index_users_on_plays", :order => {"plays"=>:desc}
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
