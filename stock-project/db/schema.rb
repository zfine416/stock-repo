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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20150311162825) do
=======
ActiveRecord::Schema.define(version: 20150311165208) do
>>>>>>> 9a7041258fbc154119c7e9c49b64ce5e131ab3d9

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

<<<<<<< HEAD
  create_table "fav_stocks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "stock_id"
=======
  create_table "stocks", force: :cascade do |t|
    t.string   "ticker"
    t.string   "name"
>>>>>>> 9a7041258fbc154119c7e9c49b64ce5e131ab3d9
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

<<<<<<< HEAD
=======
  create_table "tweets", force: :cascade do |t|
    t.string   "tweet_sender"
    t.text     "tweet_text"
    t.datetime "tweet_sent"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

>>>>>>> 9a7041258fbc154119c7e9c49b64ce5e131ab3d9
  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "session_token"
    t.string   "favorite_stocks"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
