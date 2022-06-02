class RaidReward < ApplicationRecord
  belongs_to :pc_name, :foreign_key => [:p_no, :result_no, :generate_no], :primary_key => [:p_no, :result_no, :generate_no], :class_name => "Name"
  belongs_to :party, -> { where(party_type: 4)}, :foreign_key => [:p_no, :result_no, :generate_no], :primary_key => [:p_no, :result_no, :generate_no], :class_name => "Party"
end
