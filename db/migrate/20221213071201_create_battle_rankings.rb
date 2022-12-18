class CreateBattleRankings < ActiveRecord::Migration[6.1]
  def change
    create_table :battle_rankings do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :p_no
      t.string :name
      t.integer :ranking_type
      t.integer :value
      t.integer :battle_type
      t.integer :battle_no
      t.integer :page_no
      t.integer :turn
      t.integer :thread_id
      t.integer :abnormal_type

      t.timestamps
    end
  end
end
