class AddSpellNameToBattleRanking < ActiveRecord::Migration[6.1]
  def change
    add_column :battle_rankings, :spell_name, :string
    add_column :battle_rankings, :orig_spell_name, :string
    add_column :battle_rankings, :base_spell_name, :string
    add_index :battle_rankings, :spell_name
    add_index :battle_rankings, :orig_spell_name
    add_index :battle_rankings, :base_spell_name
  end
end
