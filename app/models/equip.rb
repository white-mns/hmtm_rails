class Equip < ApplicationRecord
  belongs_to :pc_name, :foreign_key => [:p_no, :result_no, :generate_no], :primary_key => [:p_no, :result_no, :generate_no], :class_name => "Name"
  belongs_to :profile, :foreign_key => [:p_no, :result_no, :generate_no], :primary_key => [:p_no, :result_no, :generate_no], :class_name => "Profile"

  scope :range_graph, ->(params)   {
    notnil().where.not(range: -1).group(:range).search(params[:q]).result.count
  }

  scope :strength_1_graph, ->(params)   {
    notnil().group(:strength_1).search(params[:q]).result.count
  }

  scope :strength_2_graph, ->(params)   {
    notnil().group(:strength_2).search(params[:q]).result.count
  }
end
