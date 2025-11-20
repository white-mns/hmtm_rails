class PartyInfo < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
      column_names
    end

    def self.ransackable_associations(auth_object = nil)
      Array(reflect_on_all_associations).map(&:name).map(&:to_s)
    end

  has_many :party_members, :foreign_key => [:result_no, :party_no, :party_type, :generate_no], :primary_key => [:result_no, :party_no, :party_type, :generate_no], :class_name => 'Party'
end
