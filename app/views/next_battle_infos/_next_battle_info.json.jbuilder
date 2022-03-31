json.extract! next_battle_info, :id, :result_no, :generate_no, :left_party_no, :right_party_no, :battle_type, :enemy_party_name_id, :enemy_num, :enemy_names, :created_at, :updated_at
json.url next_battle_info_url(next_battle_info, format: :json)
