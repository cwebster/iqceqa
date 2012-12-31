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

ActiveRecord::Schema.define(:version => 20121231151819) do

  create_table "analysers", :force => true do |t|
    t.string   "AnalyserName"
    t.text     "AnalyserNote"
    t.string   "AnalyserLocation"
    t.integer  "iqc_data_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "analysers", ["id"], :name => "index_analysers_on_id"
  add_index "analysers", ["iqc_data_id"], :name => "index_analysers_on_iqc_data_id"

  create_table "change_loggings", :force => true do |t|
    t.datetime "dateTimeLogged"
    t.string   "logRecord"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "eqa_schemes", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.text     "contact"
    t.string   "website"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "eqas", :force => true do |t|
    t.float    "bias"
    t.string   "notes"
    t.integer  "test_code_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "eqa_scheme_id"
  end

  add_index "eqas", ["id"], :name => "index_eqas_on_id"

  create_table "iqc_data", :force => true do |t|
    t.string   "notes"
    t.datetime "dateTimeCreated"
    t.string   "result"
    t.integer  "iqc_id"
    t.integer  "test_code_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "analyser_id"
  end

  add_index "iqc_data", ["analyser_id"], :name => "index_iqc_data_on_analyser_id"

  create_table "iqcs", :force => true do |t|
    t.string   "name"
    t.string   "manufacturer"
    t.string   "notes"
    t.boolean  "assigned"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "quality_specifications", :force => true do |t|
    t.float    "bias"
    t.float    "imprecision"
    t.integer  "test_code_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "sigmas", :force => true do |t|
    t.float    "sigma"
    t.integer  "test_code_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "targets", :force => true do |t|
    t.integer  "IQCID"
    t.datetime "dateTimeValid"
    t.string   "notes"
    t.string   "testCode"
    t.float    "target"
    t.integer  "iqc_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "targets", ["IQCID"], :name => "index_targets_on_IQCID"

  create_table "test_codes", :force => true do |t|
    t.string   "testCodeText"
    t.string   "testExpansion"
    t.string   "notes"
    t.boolean  "active"
    t.integer  "testCode"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
