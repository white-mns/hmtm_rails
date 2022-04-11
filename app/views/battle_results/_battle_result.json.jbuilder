json.extract! battle_result, :id, :result_no, :generate_no, :previous_result_no, :previous_generate_no, :left_party_no, :right_party_no, :battle_no, :battle_type, :battle_result, :enemy_party_name_id, :enemy_num, :enemy_names, :created_at, :updated_at
json.url battle_result_url(battle_result, format: :json)
