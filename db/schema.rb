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

ActiveRecord::Schema.define(version: 20180421174858) do

  create_table "cases", force: :cascade do |t|
    t.string   "reference"
    t.string   "description"
    t.integer  "client_id"
    t.integer  "casestatus_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "company_id"
  end

  add_index "cases", ["casestatus_id"], name: "index_cases_on_casestatus_id"
  add_index "cases", ["client_id"], name: "index_cases_on_client_id"
  add_index "cases", ["company_id"], name: "index_cases_on_company_id"

  create_table "casestatuses", force: :cascade do |t|
    t.string   "code"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string   "firstname"
    t.string   "middlename"
    t.string   "lastname"
    t.integer  "clientstatus_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "company_id"
  end

  add_index "clients", ["clientstatus_id"], name: "index_clients_on_clientstatus_id"
  add_index "clients", ["company_id"], name: "index_clients_on_company_id"

  create_table "clientstatuses", force: :cascade do |t|
    t.string   "code"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "nominals", force: :cascade do |t|
    t.string   "code"
    t.string   "desc"
    t.boolean  "isoffice"
    t.boolean  "isclient"
    t.boolean  "isdeposit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "company_id"
  end

  add_index "nominals", ["company_id"], name: "index_nominals_on_company_id"

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
    t.integer  "tranhead_id"
    t.integer  "case_id"
    t.integer  "company_id"
  end

  add_index "nomtrans", ["case_id"], name: "index_nomtrans_on_case_id"
  add_index "nomtrans", ["company_id"], name: "index_nomtrans_on_company_id"
  add_index "nomtrans", ["nominal_id"], name: "index_nomtrans_on_nominal_id"
  add_index "nomtrans", ["supplier_id"], name: "index_nomtrans_on_supplier_id"
  add_index "nomtrans", ["tran_id"], name: "index_nomtrans_on_tran_id"
  add_index "nomtrans", ["tranhead_id"], name: "index_nomtrans_on_tranhead_id"
  add_index "nomtrans", ["vat_id"], name: "index_nomtrans_on_vat_id"

  create_table "outlaytypes", force: :cascade do |t|
    t.string   "outcode"
    t.string   "outdesc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "supcode"
    t.string   "supname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "company_id"
  end

  add_index "suppliers", ["company_id"], name: "index_suppliers_on_company_id"

  create_table "tranheads", force: :cascade do |t|
    t.string   "trref"
    t.date     "trdate"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "bank_id"
    t.string   "type"
    t.string   "troffcli"
    t.string   "trpayrec"
    t.string   "trtrantype"
    t.string   "trotherref"
    t.integer  "supplier_id"
    t.integer  "transfer_id"
    t.integer  "case_id_id"
    t.integer  "case_id"
    t.integer  "company_id"
  end

  add_index "tranheads", ["bank_id"], name: "index_tranheads_on_bank_id"
  add_index "tranheads", ["case_id"], name: "index_tranheads_on_case_id"
  add_index "tranheads", ["case_id_id"], name: "index_tranheads_on_case_id_id"
  add_index "tranheads", ["company_id"], name: "index_tranheads_on_company_id"
  add_index "tranheads", ["supplier_id"], name: "index_tranheads_on_supplier_id"
  add_index "tranheads", ["transfer_id"], name: "index_tranheads_on_transfer_id"
  add_index "tranheads", ["troffcli"], name: "index_tranheads_on_troffcli"
  add_index "tranheads", ["trpayrec"], name: "index_tranheads_on_trpayrec"
  add_index "tranheads", ["trtrantype"], name: "index_tranheads_on_trtrantype"

  create_table "trans", force: :cascade do |t|
    t.string   "trdetails"
    t.decimal  "tramount",          precision: 15, scale: 2
    t.integer  "tranhead_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "nominal_id"
    t.integer  "vat_id"
    t.decimal  "vatperc",           precision: 15, scale: 2
    t.decimal  "vatamount",         precision: 15, scale: 2
    t.decimal  "netamount",         precision: 15, scale: 2
    t.integer  "supplier_id"
    t.string   "type"
    t.boolean  "thirdp"
    t.integer  "outlaytype_id"
    t.string   "troutlaybill"
    t.decimal  "outamount",         precision: 10, scale: 2
    t.integer  "fromclientbank_id"
    t.integer  "case_id"
    t.integer  "company_id"
  end

  add_index "trans", ["case_id"], name: "index_trans_on_case_id"
  add_index "trans", ["company_id"], name: "index_trans_on_company_id"
  add_index "trans", ["fromclientbank_id"], name: "index_trans_on_fromclientbank_id"
  add_index "trans", ["nominal_id"], name: "index_trans_on_nominal_id"
  add_index "trans", ["outlaytype_id"], name: "index_trans_on_outlaytype_id"
  add_index "trans", ["supplier_id"], name: "index_trans_on_supplier_id"
  add_index "trans", ["tranhead_id"], name: "index_trans_on_tranhead_id"
  add_index "trans", ["vat_id"], name: "index_trans_on_vat_id"

  create_table "transfers", force: :cascade do |t|
    t.string   "type"
    t.date     "date"
    t.string   "reference"
    t.decimal  "amount",         precision: 15, scale: 2
    t.string   "fromdetails"
    t.integer  "frombank_id"
    t.integer  "fromnominal_id"
    t.string   "todetails"
    t.integer  "tobank_id"
    t.integer  "tonominal_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "fromtype"
    t.string   "totype"
    t.string   "trantype"
    t.integer  "fromcase_id"
    t.integer  "tocase_id"
    t.integer  "company_id"
  end

  add_index "transfers", ["company_id"], name: "index_transfers_on_company_id"
  add_index "transfers", ["frombank_id"], name: "index_transfers_on_frombank_id"
  add_index "transfers", ["fromcase_id"], name: "index_transfers_on_fromcase_id"
  add_index "transfers", ["fromnominal_id"], name: "index_transfers_on_fromnominal_id"
  add_index "transfers", ["tobank_id"], name: "index_transfers_on_tobank_id"
  add_index "transfers", ["tocase_id"], name: "index_transfers_on_tocase_id"
  add_index "transfers", ["tonominal_id"], name: "index_transfers_on_tonominal_id"

  create_table "vats", force: :cascade do |t|
    t.decimal  "vatperc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "vatcode"
  end

end
