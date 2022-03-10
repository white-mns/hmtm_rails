class AddIndexToTeachSpell < ActiveRecord::Migration[6.1]
  def change
    add_index :teach_spells, [:result_no, :p_no, :generate_no], :unique => false, :name => 'resultno_pno'
    add_index :teach_spells, [:previous_result_no, :p_no, :previous_generate_no], :unique => false, :name => 'previousresultno_pno'
    add_index :teach_spells, :s_no
    add_index :teach_spells, :num
    add_index :teach_spells, :op
  end
end
