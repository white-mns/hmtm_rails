class Status < ApplicationRecord
  belongs_to :pc_name, :foreign_key => [:p_no, :result_no, :generate_no], :primary_key => [:p_no, :result_no, :generate_no], :class_name => "Name"
  belongs_to :rank, :foreign_key => :rank_id, :primary_key => :proper_id, :class_name => "ProperName"
end
