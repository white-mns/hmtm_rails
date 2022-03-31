class CreateNextBattleInfos < ActiveRecord::Migration[6.1]
  def change
    create_table :next_battle_infos do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :left_party_no
      t.integer :right_party_no
      t.integer :battle_type
      t.integer :enemy_party_name_id
      t.integer :enemy_num
      t.string :enemy_names

      t.timestamps
    end
  end
end
