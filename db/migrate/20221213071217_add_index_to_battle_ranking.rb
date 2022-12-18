class AddIndexToBattleRanking < ActiveRecord::Migration[6.1]
  def change
    add_index :battle_rankings, [:result_no, :ranking_type, :battle_type, :p_no, :generate_no], :name => 'resultno_rankingtype_battletype_battleno'
    add_index :battle_rankings, [:result_no, :ranking_type, :p_no, :generate_no], :name => 'resultno_rankingtype_battleno'
    add_index :battle_rankings, :name
    add_index :battle_rankings, :value
    add_index :battle_rankings, :battle_no
    add_index :battle_rankings, :page_no
    add_index :battle_rankings, :turn
    add_index :battle_rankings, :thread_id
    add_index :battle_rankings, :abnormal_type
  end
end
