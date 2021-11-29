class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :p_no
      t.string :title
      t.string :nickname
      t.integer :subject_id
      t.integer :course_id
      t.string :species
      t.string :sexuality
      t.string :age

      t.timestamps
    end
  end
end
