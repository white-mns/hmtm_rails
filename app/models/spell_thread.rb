class SpellThread < ApplicationRecord
  has_many :thread_members, ->{order('p_no ASC')}, :foreign_key => [:result_no, :battle_type, :battle_no, :turn, :thread_id, :generate_no], :primary_key => [:result_no, :battle_type, :battle_no, :turn, :thread_id, :generate_no], :class_name => 'SpellThreadMember'
end
