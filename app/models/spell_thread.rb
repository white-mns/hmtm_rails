class SpellThread < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
      column_names
    end

    def self.ransackable_associations(auth_object = nil)
      Array(reflect_on_all_associations).map(&:name).map(&:to_s)
    end

  has_many :thread_members, ->{order('p_no ASC')}, :foreign_key => [:result_no, :battle_type, :battle_no, :page_no, :turn, :thread_id, :generate_no], :primary_key => [:result_no, :battle_type, :battle_no, :page_no, :turn, :thread_id, :generate_no], :class_name => 'SpellThreadMember'
end
