json.extract! party_info, :id, :result_no, :generate_no, :party_type, :party_no, :name, :member_num, :attacker_num, :supporter_num, :created_at, :updated_at
json.url party_info_url(party_info, format: :json)
