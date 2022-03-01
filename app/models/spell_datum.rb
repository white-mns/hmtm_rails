class SpellDatum < ApplicationRecord
  belongs_to :base_spell, :foreign_key => :base_spell_id, :primary_key => :spell_id, :class_name => "SpellDatum"
  belongs_to :element,    :foreign_key => :element_id,    :primary_key => :proper_id, :class_name => "ProperName"
  belongs_to :timing,     :foreign_key => :timing_id,     :primary_key => :proper_id, :class_name => "ProperName"
  belongs_to :class_data, :foreign_key => :class_id,      :primary_key => :proper_id, :class_name => "ProperName"
end
