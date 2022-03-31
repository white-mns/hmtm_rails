class NextBattleInfo < ApplicationRecord
  belongs_to :left_party_info,  :foreign_key => [:result_no, :left_party_no, :battle_type, :generate_no],  :primary_key => [:result_no, :party_no, :party_type, :generate_no], :class_name => 'PartyInfo'
  belongs_to :right_party_info, :foreign_key => [:result_no, :right_party_no, :battle_type, :generate_no], :primary_key => [:result_no, :party_no, :party_type, :generate_no], :class_name => 'PartyInfo'
  belongs_to :enemy_party_name, :foreign_key => :enemy_party_name_id, :primary_key => :proper_id, :class_name => "ProperName"
end
