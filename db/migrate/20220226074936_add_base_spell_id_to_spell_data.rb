class AddBaseSpellIdToSpellData < ActiveRecord::Migration[6.1]
  def change
    add_column :spell_data, :base_spell_id, :integer
    add_index  :spell_data, :base_spell_id
  end
end
