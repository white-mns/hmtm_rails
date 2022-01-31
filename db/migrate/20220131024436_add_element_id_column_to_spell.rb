class AddElementIdColumnToSpell < ActiveRecord::Migration[6.1]
  def change
    add_column :spells, :element_id, :integer
    add_index :spells, :element_id
  end
end
