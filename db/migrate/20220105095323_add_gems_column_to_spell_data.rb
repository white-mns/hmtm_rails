class AddGemsColumnToSpellData < ActiveRecord::Migration[6.1]
  def change
    add_column :spell_data, :gems, :string
    add_index :spell_data, :gems
  end
end
