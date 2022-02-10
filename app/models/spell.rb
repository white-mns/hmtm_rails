class Spell < ApplicationRecord
  belongs_to :pc_name, :foreign_key => [:p_no, :result_no, :generate_no], :primary_key => [:p_no, :result_no, :generate_no], :class_name => "Name"
  belongs_to :profile, :foreign_key => [:p_no, :result_no, :generate_no], :primary_key => [:p_no, :result_no, :generate_no], :class_name => "Profile"
  belongs_to :timing,  :foreign_key => :timing_id,  :primary_key => :proper_id, :class_name => "ProperName"
  belongs_to :element, :foreign_key => :element_id, :primary_key => :proper_id, :class_name => "ProperName"
  belongs_to :spell,   :foreign_key => :spell_id,   :primary_key => :spell_id,  :class_name => "SpellDatum"
end
