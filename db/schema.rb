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

ActiveRecord::Schema.define(version: 20170317140039) do

  create_table "addresses", force: :cascade do |t|
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "agents", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "email"
    t.string   "license_number"
    t.integer  "brokerage_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["brokerage_id"], name: "index_agents_on_brokerage_id"
  end

  create_table "bootsy_image_galleries", force: :cascade do |t|
    t.string   "bootsy_resource_type"
    t.integer  "bootsy_resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: :cascade do |t|
    t.string   "image_file"
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brokerages", force: :cascade do |t|
    t.integer  "address_id"
    t.string   "name"
    t.string   "license_number"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["address_id"], name: "index_brokerages_on_address_id"
  end

  create_table "buyer_title_orders", force: :cascade do |t|
    t.integer  "buyer_id"
    t.integer  "title_order_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["buyer_id"], name: "index_buyer_title_orders_on_buyer_id"
    t.index ["title_order_id"], name: "index_buyer_title_orders_on_title_order_id"
  end

  create_table "buyers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "email"
    t.integer  "address_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "spouse_id"
    t.integer  "mailing_address_id"
    t.index ["address_id"], name: "index_buyers_on_address_id"
    t.index ["mailing_address_id"], name: "index_buyers_on_mailing_address_id"
    t.index ["spouse_id"], name: "index_buyers_on_spouse_id"
  end

  create_table "lenders", force: :cascade do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "email"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "posts", force: :cascade do |t|
    t.text     "body"
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "title_orders", force: :cascade do |t|
    t.integer  "property_id"
    t.integer  "buyers_agent_id"
    t.integer  "sellers_agent_id"
    t.integer  "lender_id"
    t.string   "title_type"
    t.string   "closing_type"
    t.string   "buyers_agent_commission"
    t.string   "sellers_agent_commission"
    t.boolean  "survey_requested",         default: true
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.text     "notes"
    t.boolean  "quote",                    default: false
    t.integer  "user_id"
    t.index ["buyers_agent_id"], name: "index_title_orders_on_buyers_agent_id"
    t.index ["lender_id"], name: "index_title_orders_on_lender_id"
    t.index ["property_id"], name: "index_title_orders_on_property_id"
    t.index ["sellers_agent_id"], name: "index_title_orders_on_sellers_agent_id"
    t.index ["user_id"], name: "index_title_orders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "name"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "activation_digest"
    t.string   "admin_digest"
  end

end
