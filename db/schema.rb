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

ActiveRecord::Schema.define(:version => 20130226081425) do

# Could not dump table "_iqc_data_old_20130118" because of following StandardError
#   Unknown type 'bool' for column 'usedInCalculation'

# Could not dump table "_sigmas_old_20130118" because of following StandardError
#   Unknown type 'bool' for column 'sigmaScoreDesirable'

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["authentication_token"], :name => "index_admins_on_authentication_token", :unique => true
  add_index "admins", ["confirmation_token"], :name => "index_admins_on_confirmation_token", :unique => true
  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true
  add_index "admins", ["unlock_token"], :name => "index_admins_on_unlock_token", :unique => true

  create_table "analysers", :force => true do |t|
    t.string   "AnalyserName"
    t.text     "AnalyserNote"
    t.string   "AnalyserLocation"
    t.integer  "iqc_data_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "users_id"
  end

  add_index "analysers", ["id"], :name => "index_analysers_on_id"
  add_index "analysers", ["iqc_data_id"], :name => "index_analysers_on_iqc_data_id"

  create_table "change_loggings", :force => true do |t|
    t.string   "logRecord"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "users_id"
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
    t.integer  "users_id"
  end

  add_index "eqas", ["analyser_id"], :name => "index_eqas_on_analyser_id"
  add_index "eqas", ["id"], :name => "index_eqas_on_id"

  create_table "form_builders", :force => true do |t|
    t.string   "form_name"
    t.string   "description"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "eqa_scheme_id"
  end

  create_table "form_configs", :force => true do |t|
    t.integer  "form_order"
    t.integer  "test_codes_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "form_builder_id"
  end

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
    t.integer  "users_id"
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
    t.integer  "users_id"
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
    t.integer  "users_id"
  end

  create_table "reportable_cache", :force => true do |t|
    t.string   "model_name",                        :null => false
    t.string   "report_name",                       :null => false
    t.string   "grouping",                          :null => false
    t.string   "aggregation",                       :null => false
    t.string   "conditions",                        :null => false
    t.float    "value",            :default => 0.0, :null => false
    t.datetime "reporting_period",                  :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "reportable_cache", ["model_name", "report_name", "grouping", "aggregation", "conditions", "reporting_period"], :name => "name_model_grouping_aggregation_period", :unique => true
  add_index "reportable_cache", ["model_name", "report_name", "grouping", "aggregation", "conditions"], :name => "name_model_grouping_agregation"

  create_table "return_forms", :force => true do |t|
    t.string   "form_name"
    t.string   "description"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "eqa_schemes_id"
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
    t.integer  "users_id"
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
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "readcode"
    t.integer  "users_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "username"
    t.boolean  "admin"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["id"], :name => "index_users_on_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
