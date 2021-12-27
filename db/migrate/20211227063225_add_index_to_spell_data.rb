class AddIndexToSpellData < ActiveRecord::Migration[6.1]
  def change
    add_index :spell_data, :spell_id
    add_index :spell_data, :name
    add_index :spell_data, :sp
    add_index :spell_data, :element_id
    add_index :spell_data, :text
    add_index :spell_data, :range
    add_index :spell_data, :power
    add_index :spell_data, :hit
    add_index :spell_data, :timing_id
    add_index :spell_data, :class_id
  end
end
