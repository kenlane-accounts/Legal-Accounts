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

ActiveRecord::Schema.define(version: 20180301123736) do

  create_table "nominals", force: :cascade do |t|
    t.string   "code"
    t.string   "desc"
    t.boolean  "isoffice"
    t.boolean  "isclient"
    t.boolean  "isdeposit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nomtrans", force: :cascade do |t|
    t.integer  "tran_id"
    t.integer  "nominal_id"
    t.date     "date"
    t.decimal  "amount"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "ttype"
    t.integer  "supplier_id"
    t.integer  "vat_id"
    t.string   "nomcode"
  end

  add_index "nomtrans", ["nominal_id"], name: "index_nomtrans_on_nominal_id"
  add_index "nomtrans", ["supplier_id"], name: "index_nomtrans_on_supplier_id"
  add_index "nomtrans", ["tran_id"], name: "index_nomtrans_on_tran_id"
  add_index "nomtrans", ["vat_id"], name: "index_nomtrans_on_vat_id"

  create_table "suppliers", force: :cascade do |t|
    t.string   "supcode"
    t.string   "supname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tranheads", force: :cascade do |t|
    t.string   "trref"
    t.date     "trdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "bank_id"
    t.string   "trtype"
    t.string   "type"
  end

  add_index "tranheads", ["bank_id"], name: "index_tranheads_on_bank_id"

  create_table "trans", force: :cascade do |t|
    t.string   "trdetails"
    t.decimal  "tramount",    precision: 15, scale: 2
    t.integer  "tranhead_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "nominal_id"
    t.integer  "vat_id"
    t.decimal  "vatperc",     precision: 15, scale: 2
    t.decimal  "vatamount",   precision: 15, scale: 2
    t.decimal  "netamount",   precision: 15, scale: 2
    t.integer  "supplier_id"
    t.string   "type"
  end

  add_index "trans", ["nominal_id"], name: "index_trans_on_nominal_id"
  add_index "trans", ["supplier_id"], name: "index_trans_on_supplier_id"
  add_index "trans", ["tranhead_id"], name: "index_trans_on_tranhead_id"
  add_index "trans", ["vat_id"], name: "index_trans_on_vat_id"

  create_table "vats", force: :cascade do |t|
    t.decimal  "vatperc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "vatcode"
  end

end
