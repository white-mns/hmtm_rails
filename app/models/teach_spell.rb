class TeachSpell < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
      column_names
    end

    def self.ransackable_associations(auth_object = nil)
      Array(reflect_on_all_associations).map(&:name).map(&:to_s)
    end

  belongs_to :pc_name, :foreign_key => [:p_no, :result_no, :generate_no], :primary_key => [:p_no, :result_no, :generate_no], :class_name => "Name"
  belongs_to :spell, :foreign_key => [:p_no, :s_no, :previous_result_no, :previous_generate_no], :primary_key => [:p_no, :s_no, :result_no, :generate_no], :class_name => "Spell"
end
