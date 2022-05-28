class PkPkk < ApplicationRecord
  belongs_to :pc_name, :foreign_key => [:p_no, :result_no, :generate_no], :primary_key => [:p_no, :result_no, :generate_no], :class_name => "Name"
  belongs_to :status,  :foreign_key => [:p_no, :result_no, :generate_no], :primary_key => [:p_no, :result_no, :generate_no], :class_name => "Status"
end
