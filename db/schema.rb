# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_01_103743) do

  create_table "equips", charset: "utf8mb4", collation: "utf8mb4_0900_as_ci", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "p_no"
    t.integer "equip_no"
    t.string "name"
    t.integer "range"
    t.integer "strength_1"
    t.integer "strength_2"
    t.string "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["equip_no"], name: "index_equips_on_equip_no"
    t.index ["name"], name: "index_equips_on_name"
    t.index ["note"], name: "index_equips_on_note"
    t.index ["range"], name: "index_equips_on_range"
    t.index ["result_no", "p_no", "equip_no", "generate_no"], name: "resultno_pno_equipno"
    t.index ["result_no", "p_no", "generate_no"], name: "resultno_pno"
    t.index ["strength_1"], name: "index_equips_on_strength_1"
    t.index ["strength_2"], name: "index_equips_on_strength_2"
  end

  create_table "names", charset: "utf8mb4", collation: "utf8mb4_0900_as_ci", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "p_no"
    t.string "name"
    t.string "player"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["result_no", "p_no", "generate_no"], name: "resultno_pno"
  end

  create_table "profiles", charset: "utf8mb4", collation: "utf8mb4_0900_as_ci", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "p_no"
    t.string "title"
    t.string "nickname"
    t.integer "subject_id"
    t.integer "course_id"
    t.string "species"
    t.string "sexuality"
    t.string "age"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["age"], name: "index_profiles_on_age"
    t.index ["course_id"], name: "index_profiles_on_course_id"
    t.index ["nickname"], name: "index_profiles_on_nickname"
    t.index ["result_no", "p_no", "generate_no"], name: "resultno_pno"
    t.index ["result_no", "p_no", "subject_id", "generate_no"], name: "resultno_pno_subjectid"
    t.index ["sexuality"], name: "index_profiles_on_sexuality"
    t.index ["species"], name: "index_profiles_on_species"
    t.index ["subject_id"], name: "index_profiles_on_subject_id"
    t.index ["title"], name: "index_profiles_on_title"
  end

  create_table "proper_names", charset: "utf8mb4", collation: "utf8mb4_0900_as_ci", force: :cascade do |t|
    t.integer "proper_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_proper_names_on_name"
    t.index ["proper_id"], name: "index_proper_names_on_proper_id"
  end

  create_table "statuses", charset: "utf8mb4", collation: "utf8mb4_0900_as_ci", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "p_no"
    t.integer "mhp"
    t.integer "mmp"
    t.integer "msp"
    t.integer "cp"
    t.integer "str"
    t.integer "def"
    t.integer "tec"
    t.integer "eva"
    t.integer "agi"
    t.integer "luk"
    t.integer "cha"
    t.integer "rank_id"
    t.integer "tp"
    t.integer "ap"
    t.integer "pp"
    t.integer "sc"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["agi"], name: "index_statuses_on_agi"
    t.index ["ap"], name: "index_statuses_on_ap"
    t.index ["cha"], name: "index_statuses_on_cha"
    t.index ["cp"], name: "index_statuses_on_cp"
    t.index ["def"], name: "index_statuses_on_def"
    t.index ["eva"], name: "index_statuses_on_eva"
    t.index ["luk"], name: "index_statuses_on_luk"
    t.index ["mhp"], name: "index_statuses_on_mhp"
    t.index ["mmp"], name: "index_statuses_on_mmp"
    t.index ["msp"], name: "index_statuses_on_msp"
    t.index ["pp"], name: "index_statuses_on_pp"
    t.index ["rank_id"], name: "index_statuses_on_rank_id"
    t.index ["result_no", "p_no", "generate_no"], name: "resultno_pno"
    t.index ["sc"], name: "index_statuses_on_sc"
    t.index ["str"], name: "index_statuses_on_str"
    t.index ["tec"], name: "index_statuses_on_tec"
    t.index ["tp"], name: "index_statuses_on_tp"
  end

  create_table "uploaded_checks", charset: "utf8mb4", collation: "utf8mb4_0900_as_ci", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["result_no", "generate_no"], name: "resultno_generateno"
  end

end
