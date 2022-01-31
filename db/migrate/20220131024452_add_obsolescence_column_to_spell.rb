class AddObsolescenceColumnToSpell < ActiveRecord::Migration[6.1]
  def change
    add_column :spells, :obsolescence, :decimal, precision:8, scale: 1
    add_index :spells, :obsolescence
  end
end
