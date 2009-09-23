# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090923021508) do

  create_table "clicks", :force => true do |t|
    t.integer  "shortening_id"
    t.string   "referer"
    t.string   "referer_host"
    t.string   "remote_ip"
    t.string   "user_agent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country"
    t.string   "city"
    t.string   "region"
  end

  create_table "shortenings", :force => true do |t|
    t.string   "url"
    t.string   "hash_key"
    t.boolean  "custom",       :default => false
    t.integer  "clicks_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shortenings", ["hash_key"], :name => "index_shortenings_on_hash_key", :unique => true
  add_index "shortenings", ["id"], :name => "index_shortenings_on_id"

end
