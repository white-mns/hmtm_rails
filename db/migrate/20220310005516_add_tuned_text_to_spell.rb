class AddTunedTextToSpell < ActiveRecord::Migration[6.1]
  def change
    add_column :spells, :tuned_text, :string
    add_index  :spells, :tuned_text
  end
end
