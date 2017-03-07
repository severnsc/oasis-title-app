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

ActiveRecord::Schema.define(version: 20170307180009) do

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

  create_table "brokerages", force: :cascade do |t|
    t.integer  "address_id"
    t.string   "name"
    t.string   "license_number"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["address_id"], name: "index_brokerages_on_address_id"
  end

  create_table "buyers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "email"
    t.integer  "address_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["address_id"], name: "index_buyers_on_address_id"
  end

  create_table "buyers_title_orders", id: false, force: :cascade do |t|
    t.integer "buyer_id"
    t.integer "title_order_id"
    t.index ["buyer_id"], name: "index_buyers_title_orders_on_buyer_id"
    t.index ["title_order_id"], name: "index_buyers_title_orders_on_title_order_id"
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
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["buyers_agent_id"], name: "index_title_orders_on_buyers_agent_id"
    t.index ["lender_id"], name: "index_title_orders_on_lender_id"
    t.index ["property_id"], name: "index_title_orders_on_property_id"
    t.index ["sellers_agent_id"], name: "index_title_orders_on_sellers_agent_id"
  end

end
