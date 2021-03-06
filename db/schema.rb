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

ActiveRecord::Schema.define(version: 2018_11_22_115130) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "factors", force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.string "subject_type"
    t.bigint "subject_id"
    t.index ["name"], name: "index_factors_on_name"
    t.index ["subject_id"], name: "index_factors_on_subject_id"
    t.index ["subject_type", "subject_id"], name: "index_factors_on_subject_type_and_subject_id"
    t.index ["subject_type"], name: "index_factors_on_subject_type"
  end

  create_table "units", force: :cascade do |t|
    t.string "name"
    t.string "kind"
    t.integer "rent"
    t.integer "capacity"
    t.boolean "agency"
    t.string "location_id"
    t.index ["location_id"], name: "index_units_on_location_id"
  end

end
