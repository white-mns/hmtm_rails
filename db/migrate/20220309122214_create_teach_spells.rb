class CreateTeachSpells < ActiveRecord::Migration[6.1]
  def change
    create_table :teach_spells do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :previous_result_no
      t.integer :previous_generate_no
      t.integer :p_no
      t.integer :s_no
      t.integer :num
      t.integer :op

      t.timestamps
    end
  end
end
