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

ActiveRecord::Schema.define(:version => 20130125142621) do

# Could not dump table "_iqc_data_old_20130118" because of following StandardError
#   Unknown type 'bool' for column 'usedInCalculation'

# Could not dump table "_sigmas_old_20130118" because of following StandardError
#   Unknown type 'bool' for column 'sigmaScoreDesirable'

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
    t.string   "logRecord"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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
    t.date     "dateOfEQA"
    t.integer  "analyser_id"
  end

  add_index "eqas", ["analyser_id"], :name => "index_eqas_on_analyser_id"
  add_index "eqas", ["id"], :name => "index_eqas_on_id"

  create_table "iqc_data", :force => true do |t|
    t.string   "notes"
    t.string   "result"
    t.integer  "iqc_id"
    t.integer  "test_code_id"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "analyser_id"
    t.datetime "dateOfIQC"
    t.integer  "usedInCalculation",     :default => 0
    t.date     "usedInCalculationDate"
  end

  add_index "iqc_data", ["analyser_id"], :name => "index_iqc_data_on_analyser_id"

  create_table "iqcs", :force => true do |t|
    t.string   "name"
    t.string   "manufacturer"
    t.string   "notes"
    t.boolean  "assigned"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "code"
    t.string   "lotno"
    t.date     "expirydate"
    t.string   "storagelocation"
    t.string   "storagetemp"
    t.date     "dateinuse"
    t.date     "datereconstituted"
    t.integer  "numberofaliquots"
  end

  create_table "quality_specifications", :force => true do |t|
    t.float    "bias"
    t.float    "imprecision"
    t.integer  "test_code_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.float    "cvi"
    t.float    "cvw"
    t.string   "goaltype"
    t.float    "allowableCVoptimal"
    t.float    "allowableCVdesirable"
    t.float    "allowableCVminimum"
    t.float    "allowableBIASoptimal"
    t.float    "allowableBIASdesirable"
    t.float    "allowableBIASminimum"
    t.float    "minimumTE"
    t.float    "desirableTE"
    t.float    "optimalTE"
  end

  create_table "sigmas", :force => true do |t|
    t.integer  "test_code_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.date     "dateOfQC"
    t.float    "qcresult"
    t.float    "eqaresult"
    t.date     "dateOfEQA"
    t.float    "allowableCVoptimal"
    t.float    "allowableCVdesirable"
    t.float    "allowableCVminimum"
    t.float    "allowableBIASoptimal"
    t.float    "allowableBIASdesirable"
    t.float    "allowableBIASminimum"
    t.float    "optimalTE"
    t.float    "desirableTE"
    t.float    "minimumTE"
    t.float    "sigmaScoreOptimal"
    t.float    "sigmaScoreDesirable"
    t.float    "sigmaScoreMinimum"
    t.string   "testname"
    t.string   "analyser"
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
