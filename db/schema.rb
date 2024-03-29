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

ActiveRecord::Schema.define(version: 2022_12_19_122355) do

  create_table "battle_rankings", charset: "utf8mb4", collation: "utf8mb4_0900_as_ci", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "p_no"
    t.string "name"
    t.integer "ranking_type"
    t.integer "value"
    t.integer "battle_type"
    t.integer "battle_no"
    t.integer "page_no"
    t.integer "turn"
    t.integer "thread_id"
    t.integer "abnormal_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "spell_name"
    t.string "orig_spell_name"
    t.string "base_spell_name"
    t.index ["abnormal_type"], name: "index_battle_rankings_on_abnormal_type"
    t.index ["base_spell_name"], name: "index_battle_rankings_on_base_spell_name"
    t.index ["battle_no"], name: "index_battle_rankings_on_battle_no"
    t.index ["name"], name: "index_battle_rankings_on_name"
    t.index ["orig_spell_name"], name: "index_battle_rankings_on_orig_spell_name"
    t.index ["page_no"], name: "index_battle_rankings_on_page_no"
    t.index ["result_no", "ranking_type", "battle_type", "p_no", "generate_no"], name: "resultno_rankingtype_battletype_battleno"
    t.index ["result_no", "ranking_type", "p_no", "generate_no"], name: "resultno_rankingtype_battleno"
    t.index ["spell_name"], name: "index_battle_rankings_on_spell_name"
    t.index ["thread_id"], name: "index_battle_rankings_on_thread_id"
    t.index ["turn"], name: "index_battle_rankings_on_turn"
    t.index ["value"], name: "index_battle_rankings_on_value"
  end

  create_table "battle_results", charset: "utf8mb4", collation: "utf8mb4_0900_as_ci", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "previous_result_no"
    t.integer "previous_generate_no"
    t.integer "left_party_no"
    t.integer "right_party_no"
    t.integer "battle_no"
    t.integer "battle_type"
    t.integer "battle_result"
    t.integer "enemy_party_name_id"
    t.integer "enemy_num"
    t.string "enemy_names"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["battle_no"], name: "index_battle_results_on_battle_no"
    t.index ["battle_result"], name: "index_battle_results_on_battle_result"
    t.index ["battle_type"], name: "index_battle_results_on_battle_type"
    t.index ["enemy_num"], name: "index_battle_results_on_enemy_num"
    t.index ["enemy_party_name_id"], name: "index_battle_results_on_enemy_party_name_id"
    t.index ["left_party_no"], name: "index_battle_results_on_left_party_no"
    t.index ["previous_result_no", "previous_generate_no"], name: "previous_resultno_generateno"
    t.index ["result_no", "generate_no"], name: "resultno_generateno"
    t.index ["right_party_no"], name: "index_battle_results_on_right_party_no"
  end

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

  create_table "items", charset: "utf8mb4", collation: "utf8mb4_0900_as_ci", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "p_no"
    t.integer "i_no"
    t.string "name"
    t.integer "type_id"
    t.integer "strength"
    t.string "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["i_no"], name: "index_items_on_i_no"
    t.index ["name"], name: "index_items_on_name"
    t.index ["note"], name: "index_items_on_note"
    t.index ["result_no", "p_no", "generate_no"], name: "resultno_pno"
    t.index ["strength"], name: "index_items_on_strength"
    t.index ["type_id"], name: "index_items_on_type_id"
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

  create_table "next_battle_infos", charset: "utf8mb4", collation: "utf8mb4_0900_as_ci", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "left_party_no"
    t.integer "right_party_no"
    t.integer "battle_type"
    t.integer "enemy_party_name_id"
    t.integer "enemy_num"
    t.string "enemy_names"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["battle_type"], name: "index_next_battle_infos_on_battle_type"
    t.index ["enemy_num"], name: "index_next_battle_infos_on_enemy_num"
    t.index ["enemy_party_name_id"], name: "index_next_battle_infos_on_enemy_party_name_id"
    t.index ["left_party_no"], name: "index_next_battle_infos_on_left_party_no"
    t.index ["result_no", "generate_no"], name: "resultno_generateno"
    t.index ["right_party_no"], name: "index_next_battle_infos_on_right_party_no"
  end

  create_table "obsolescences", charset: "utf8mb4", collation: "utf8mb4_0900_as_ci", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.string "gems"
    t.integer "gem_num"
    t.decimal "obsolescence", precision: 8, scale: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["gem_num"], name: "index_obsolescences_on_gem_num"
    t.index ["gems"], name: "index_obsolescences_on_gems"
    t.index ["obsolescence"], name: "index_obsolescences_on_obsolescence"
    t.index ["result_no", "generate_no"], name: "resultno_generateno"
  end

  create_table "parties", charset: "utf8mb4", collation: "utf8mb4_0900_as_ci", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "p_no"
    t.integer "party_type"
    t.integer "party_no"
    t.integer "is_supporter"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["is_supporter"], name: "index_parties_on_is_supporter"
    t.index ["party_type"], name: "index_parties_on_party_type"
    t.index ["result_no", "p_no", "generate_no"], name: "resultno_pno"
    t.index ["result_no", "party_no", "generate_no"], name: "resultno_partyno"
  end

  create_table "party_infos", charset: "utf8mb4", collation: "utf8mb4_0900_as_ci", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "party_type"
    t.integer "party_no"
    t.string "name"
    t.integer "member_num"
    t.integer "attacker_num"
    t.integer "supporter_num"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "pk_type"
    t.index ["attacker_num"], name: "index_party_infos_on_attacker_num"
    t.index ["member_num"], name: "index_party_infos_on_member_num"
    t.index ["name"], name: "index_party_infos_on_name"
    t.index ["party_type"], name: "index_party_infos_on_party_type"
    t.index ["pk_type"], name: "index_party_infos_on_pk_type"
    t.index ["result_no", "party_no", "generate_no"], name: "resultno_partyno"
    t.index ["supporter_num"], name: "index_party_infos_on_supporter_num"
  end

  create_table "pk_pkks", charset: "utf8mb4", collation: "utf8mb4_0900_as_ci", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "p_no"
    t.integer "pvp_type"
    t.integer "total_match_num"
    t.integer "total_battle_num"
    t.integer "total_cheer_num"
    t.integer "total_win_num"
    t.integer "total_draw_num"
    t.integer "total_lose_num"
    t.integer "total_income"
    t.integer "last_announcement_result_no"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["last_announcement_result_no"], name: "index_pk_pkks_on_last_announcement_result_no"
    t.index ["pvp_type"], name: "index_pk_pkks_on_pvp_type"
    t.index ["result_no", "p_no", "generate_no"], name: "resultno_pno"
    t.index ["total_battle_num"], name: "index_pk_pkks_on_total_battle_num"
    t.index ["total_cheer_num"], name: "index_pk_pkks_on_total_cheer_num"
    t.index ["total_draw_num"], name: "index_pk_pkks_on_total_draw_num"
    t.index ["total_income"], name: "index_pk_pkks_on_total_income"
    t.index ["total_lose_num"], name: "index_pk_pkks_on_total_lose_num"
    t.index ["total_match_num"], name: "index_pk_pkks_on_total_match_num"
    t.index ["total_win_num"], name: "index_pk_pkks_on_total_win_num"
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

  create_table "raid_rewards", charset: "utf8mb4", collation: "utf8mb4_0900_as_ci", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "p_no"
    t.integer "sc"
    t.integer "tp"
    t.integer "rp"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["result_no", "p_no", "generate_no"], name: "resultno_pno"
    t.index ["rp"], name: "index_raid_rewards_on_rp"
    t.index ["sc"], name: "index_raid_rewards_on_sc"
    t.index ["tp"], name: "index_raid_rewards_on_tp"
  end

  create_table "ranks", charset: "utf8mb4", collation: "utf8mb4_0900_as_ci", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "p_no"
    t.integer "rp"
    t.integer "total_match_num"
    t.integer "total_win_num"
    t.integer "total_draw_num"
    t.integer "total_lose_num"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["result_no", "p_no", "generate_no"], name: "resultno_pno"
    t.index ["rp"], name: "index_ranks_on_rp"
    t.index ["total_draw_num"], name: "index_ranks_on_total_draw_num"
    t.index ["total_lose_num"], name: "index_ranks_on_total_lose_num"
    t.index ["total_match_num"], name: "index_ranks_on_total_match_num"
    t.index ["total_win_num"], name: "index_ranks_on_total_win_num"
  end

  create_table "spell_data", charset: "utf8mb4", collation: "utf8mb4_0900_as_ci", force: :cascade do |t|
    t.integer "spell_id"
    t.string "name"
    t.integer "sp"
    t.integer "element_id"
    t.string "text"
    t.integer "range"
    t.integer "power"
    t.integer "hit"
    t.integer "timing_id"
    t.integer "class_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "gems"
    t.integer "base_spell_id"
    t.index ["base_spell_id"], name: "index_spell_data_on_base_spell_id"
    t.index ["class_id"], name: "index_spell_data_on_class_id"
    t.index ["element_id"], name: "index_spell_data_on_element_id"
    t.index ["gems"], name: "index_spell_data_on_gems"
    t.index ["hit"], name: "index_spell_data_on_hit"
    t.index ["name"], name: "index_spell_data_on_name"
    t.index ["power"], name: "index_spell_data_on_power"
    t.index ["range"], name: "index_spell_data_on_range"
    t.index ["sp"], name: "index_spell_data_on_sp"
    t.index ["spell_id"], name: "index_spell_data_on_spell_id"
    t.index ["text"], name: "index_spell_data_on_text"
    t.index ["timing_id"], name: "index_spell_data_on_timing_id"
  end

  create_table "spell_thread_members", charset: "utf8mb4", collation: "utf8mb4_0900_as_ci", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "battle_type"
    t.integer "battle_no"
    t.integer "turn"
    t.integer "thread_id"
    t.integer "p_no"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "page_no"
    t.index ["battle_no"], name: "index_spell_thread_members_on_battle_no"
    t.index ["battle_type"], name: "index_spell_thread_members_on_battle_type"
    t.index ["name"], name: "index_spell_thread_members_on_name"
    t.index ["p_no"], name: "index_spell_thread_members_on_p_no"
    t.index ["page_no"], name: "index_spell_thread_members_on_page_no"
    t.index ["result_no", "battle_type", "battle_no", "thread_id", "generate_no"], name: "resultno_battletype_battleno_threadid"
    t.index ["thread_id"], name: "index_spell_thread_members_on_thread_id"
    t.index ["turn"], name: "index_spell_thread_members_on_turn"
  end

  create_table "spell_threads", charset: "utf8mb4", collation: "utf8mb4_0900_as_ci", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "battle_type"
    t.integer "battle_no"
    t.integer "turn"
    t.integer "thread_id"
    t.text "thread"
    t.text "thread_tg"
    t.text "thread_orig"
    t.text "thread_orig_tg"
    t.text "thread_base"
    t.text "thread_base_tg"
    t.integer "depth"
    t.integer "length"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "page_no"
    t.index ["battle_no"], name: "index_spell_threads_on_battle_no"
    t.index ["battle_type"], name: "index_spell_threads_on_battle_type"
    t.index ["depth"], name: "index_spell_threads_on_depth"
    t.index ["length"], name: "index_spell_threads_on_length"
    t.index ["page_no"], name: "index_spell_threads_on_page_no"
    t.index ["result_no", "battle_type", "battle_no", "thread_id", "generate_no"], name: "resultno_battletype_battleno_threadid"
    t.index ["thread_id"], name: "index_spell_threads_on_thread_id"
    t.index ["turn"], name: "index_spell_threads_on_turn"
  end

  create_table "spells", charset: "utf8mb4", collation: "utf8mb4_0900_as_ci", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "p_no"
    t.integer "s_no"
    t.string "name"
    t.integer "sp"
    t.integer "power"
    t.integer "hit"
    t.integer "range"
    t.integer "timing_id"
    t.integer "spell_id"
    t.string "gems"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "element_id"
    t.decimal "obsolescence", precision: 8, scale: 1
    t.string "tuned_text"
    t.index ["element_id"], name: "index_spells_on_element_id"
    t.index ["gems"], name: "index_spells_on_gems"
    t.index ["hit"], name: "index_spells_on_hit"
    t.index ["name"], name: "index_spells_on_name"
    t.index ["obsolescence"], name: "index_spells_on_obsolescence"
    t.index ["power"], name: "index_spells_on_power"
    t.index ["range"], name: "index_spells_on_range"
    t.index ["result_no", "p_no", "generate_no"], name: "resultno_pno"
    t.index ["s_no"], name: "index_spells_on_s_no"
    t.index ["sp"], name: "index_spells_on_sp"
    t.index ["spell_id"], name: "index_spells_on_spell_id"
    t.index ["timing_id"], name: "index_spells_on_timing_id"
    t.index ["tuned_text"], name: "index_spells_on_tuned_text"
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

  create_table "teach_spells", charset: "utf8mb4", collation: "utf8mb4_0900_as_ci", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "previous_result_no"
    t.integer "previous_generate_no"
    t.integer "p_no"
    t.integer "s_no"
    t.integer "num"
    t.integer "op"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["num"], name: "index_teach_spells_on_num"
    t.index ["op"], name: "index_teach_spells_on_op"
    t.index ["previous_result_no", "p_no", "previous_generate_no"], name: "previousresultno_pno"
    t.index ["result_no", "p_no", "generate_no"], name: "resultno_pno"
    t.index ["s_no"], name: "index_teach_spells_on_s_no"
  end

  create_table "tune_gem_data", charset: "utf8mb4", collation: "utf8mb4_0900_as_ci", force: :cascade do |t|
    t.integer "tg_id"
    t.string "name"
    t.string "sp"
    t.integer "type_id"
    t.string "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_tune_gem_data_on_name"
    t.index ["sp"], name: "index_tune_gem_data_on_sp"
    t.index ["text"], name: "index_tune_gem_data_on_text"
    t.index ["tg_id"], name: "index_tune_gem_data_on_tg_id"
    t.index ["type_id"], name: "index_tune_gem_data_on_type_id"
  end

  create_table "tuning_abilities", charset: "utf8mb4", collation: "utf8mb4_0900_as_ci", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "p_no"
    t.integer "s_no"
    t.string "name"
    t.integer "merit_id"
    t.integer "merit_value"
    t.integer "demerit_id"
    t.integer "demerit_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["demerit_id"], name: "index_tuning_abilities_on_demerit_id"
    t.index ["demerit_value"], name: "index_tuning_abilities_on_demerit_value"
    t.index ["merit_id"], name: "index_tuning_abilities_on_merit_id"
    t.index ["merit_value"], name: "index_tuning_abilities_on_merit_value"
    t.index ["name"], name: "index_tuning_abilities_on_name"
    t.index ["result_no", "p_no", "generate_no"], name: "resultno_pno"
    t.index ["s_no"], name: "index_tuning_abilities_on_s_no"
  end

  create_table "uploaded_checks", charset: "utf8mb4", collation: "utf8mb4_0900_as_ci", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["result_no", "generate_no"], name: "resultno_generateno"
  end

end
