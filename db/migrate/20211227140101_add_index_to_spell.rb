class AddIndexToSpell < ActiveRecord::Migration[6.1]
  def change
    add_index :spells, [:result_no, :p_no, :generate_no], :name => 'resultno_pno'
    add_index :spells, :s_no
    add_index :spells, :name
    add_index :spells, :sp
    add_index :spells, :power
    add_index :spells, :hit
    add_index :spells, :range
    add_index :spells, :timing_id
    add_index :spells, :spell_id
    add_index :spells, :gems
  end
end
