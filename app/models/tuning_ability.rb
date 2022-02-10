class TuningAbility < ApplicationRecord
  belongs_to :pc_name, :foreign_key => [:p_no, :result_no, :generate_no], :primary_key => [:p_no, :result_no, :generate_no], :class_name => "Name"
  belongs_to :profile, :foreign_key => [:p_no, :result_no, :generate_no], :primary_key => [:p_no, :result_no, :generate_no], :class_name => "Profile"
  belongs_to :spell,   :foreign_key => [:p_no, :s_no, :result_no, :generate_no], :primary_key => [:p_no, :s_no, :result_no, :generate_no], :class_name => "Spell"
  belongs_to :merit,   :foreign_key => :merit_id,   :primary_key => :proper_id, :class_name => "ProperName"
  belongs_to :demerit, :foreign_key => :demerit_id, :primary_key => :proper_id, :class_name => "ProperName"
end
