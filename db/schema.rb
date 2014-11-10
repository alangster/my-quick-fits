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

ActiveRecord::Schema.define(version: 20141106210558) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: true do |t|
    t.integer  "wardrobe_id"
    t.integer  "category_id"
    t.string   "primary_color"
    t.string   "primary_color_hex"
    t.string   "secondary_color"
    t.string   "secondary_color_hex"
    t.string   "tertiary_color"
    t.string   "tertiary_color_hex"
    t.string   "pattern"
    t.string   "fabric"
    t.boolean  "formal?"
    t.boolean  "water_proof?"
    t.boolean  "water_delicate?"
    t.integer  "times_worn"
    t.string   "condition"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "type_of"
    t.string   "name"
    t.integer  "layerable"
    t.integer  "min_temp"
    t.integer  "max_temp"
    t.integer  "formality"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "outfit_articles", force: true do |t|
    t.integer  "outfit_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "outfits", force: true do |t|
    t.integer  "wardrobe_id"
    t.integer  "like"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wardrobes", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
