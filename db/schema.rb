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

ActiveRecord::Schema.define(version: 20200324171947) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "office_visits", force: :cascade do |t|
    t.integer  "patient_id"
    t.date     "date"
    t.string   "hour"
    t.string   "status"
    t.integer  "payment_method"
    t.string   "treatment"
    t.float    "value"
    t.string   "upload"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["patient_id"], name: "index_office_visits_on_patient_id", using: :btree
  end

  create_table "parcels", force: :cascade do |t|
    t.integer  "office_visit_id"
    t.float    "value"
    t.string   "observation"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["office_visit_id"], name: "index_parcels_on_office_visit_id", using: :btree
  end

  create_table "patients", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "document"
    t.string   "address"
    t.string   "telephone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_patients_on_user_id", using: :btree
  end

  create_table "spents", force: :cascade do |t|
    t.integer  "patient_id"
    t.float    "value"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["patient_id"], name: "index_spents_on_patient_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                                null: false
    t.integer  "messages_sent",          default: 0
    t.date     "payment_expiration"
    t.integer  "payment_status"
    t.integer  "plan",                   default: 0
    t.integer  "role",                   default: 0
    t.string   "avatar"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
