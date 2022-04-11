class AddIndexToBattleResult < ActiveRecord::Migration[6.1]
  def change
    add_index :battle_results, [:result_no, :generate_no], :unique => false, :name => 'resultno_generateno'
    add_index :battle_results, [:previous_result_no, :previous_generate_no], :unique => false, :name => 'previous_resultno_generateno'
    add_index :battle_results, :left_party_no
    add_index :battle_results, :right_party_no
    add_index :battle_results, :battle_no
    add_index :battle_results, :battle_type
    add_index :battle_results, :battle_result
    add_index :battle_results, :enemy_party_name_id
    add_index :battle_results, :enemy_num
  end
end
