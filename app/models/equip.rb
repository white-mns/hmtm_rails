class Equip < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
      column_names
    end

    def self.ransackable_associations(auth_object = nil)
      Array(reflect_on_all_associations).map(&:name).map(&:to_s)
    end

  belongs_to :pc_name, :foreign_key => [:p_no, :result_no, :generate_no], :primary_key => [:p_no, :result_no, :generate_no], :class_name => "Name"
  belongs_to :profile, :foreign_key => [:p_no, :result_no, :generate_no], :primary_key => [:p_no, :result_no, :generate_no], :class_name => "Profile"

  scope :range_graph, ->(params)   {
    notnil().where.not(range: -1).group(:range).ransack(params[:q]).result.count
  }

  scope :strength_1_graph, ->(params)   {
    notnil().group(:strength_1).ransack(params[:q]).result.count
  }

  scope :strength_2_graph, ->(params)   {
    notnil().group(:strength_2).ransack(params[:q]).result.count
  }
end
