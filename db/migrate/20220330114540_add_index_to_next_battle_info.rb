class AddIndexToNextBattleInfo < ActiveRecord::Migration[6.1]
  def change
    add_index :next_battle_infos, [:result_no, :generate_no], :unique => false, :name => 'resultno_generateno'
    add_index :next_battle_infos, :left_party_no
    add_index :next_battle_infos, :right_party_no
    add_index :next_battle_infos, :battle_type
    add_index :next_battle_infos, :enemy_party_name_id
    add_index :next_battle_infos, :enemy_num
  end
end
