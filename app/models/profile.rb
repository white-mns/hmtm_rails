class Profile < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
      column_names
    end

    def self.ransackable_associations(auth_object = nil)
      Array(reflect_on_all_associations).map(&:name).map(&:to_s)
    end

  proper_name = ProperName.pluck(:name, :proper_id).inject(Hash.new(0)){|hash, a| hash[a[0]] = a[1] ; hash}
  belongs_to :pc_name, :foreign_key => [:p_no, :result_no, :generate_no], :primary_key => [:p_no, :result_no, :generate_no], :class_name => "Name"
  belongs_to :course, :foreign_key => :course_id, :primary_key => :proper_id, :class_name => "ProperName"

  scope :subject_graph, ->(params)   {
    notnil().group(:subject_id).ransack(params[:q]).result.subject_id_to_name()
  }

  scope :course_graph, ->(params)   {
    notnil().group(:course_id).ransack(params[:q]).result.course_id_to_name()
  }

  scope :subject_id_to_name, ->()   {
    hash = self.count
    hash[:魔術科] = hash.delete(0)
    hash[:武術科] = hash.delete(1)
    hash
  }

  scope :course_id_to_name, ->()   {
    hash = self.count
    hash[:？] = hash.delete(0)
    hash[:初等部] = hash.delete(proper_name["初等部"])
    hash[:中等部] = hash.delete(proper_name["中等部"])
    hash[:高等部] = hash.delete(proper_name["高等部"])
    hash[:大学部] = hash.delete(proper_name["大学部"])
    hash
  }
end
