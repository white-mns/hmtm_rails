class AddIndexToProfile < ActiveRecord::Migration[6.1]
  def change
    add_index :profiles, [:result_no, :p_no, :generate_no], :unique => false, :name => 'resultno_pno'
    add_index :profiles, [:result_no, :p_no, :subject_id, :generate_no], :unique => false, :name => 'resultno_pno_subjectid'
    add_index :profiles, :title
    add_index :profiles, :nickname
    add_index :profiles, :subject_id
    add_index :profiles, :course_id
    add_index :profiles, :species
    add_index :profiles, :sexuality
    add_index :profiles, :age
  end
end
