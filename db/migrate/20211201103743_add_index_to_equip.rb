class AddIndexToEquip < ActiveRecord::Migration[6.1]
  def change
    add_index :equips, [:result_no, :p_no, :generate_no], :name => 'resultno_pno'
    add_index :equips, [:result_no, :p_no, :equip_no, :generate_no], :name => 'resultno_pno_equipno'
    add_index :equips, :equip_no
    add_index :equips, :name
    add_index :equips, :range
    add_index :equips, :strength_1
    add_index :equips, :strength_2
    add_index :equips, :note
  end
end
