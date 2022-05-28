class CreatePkPkks < ActiveRecord::Migration[6.1]
  def change
    create_table :pk_pkks do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :p_no
      t.integer :pvp_type
      t.integer :total_match_num
      t.integer :total_battle_num
      t.integer :total_cheer_num
      t.integer :total_win_num
      t.integer :total_draw_num
      t.integer :total_lose_num
      t.integer :total_income
      t.integer :last_announcement_result_no

      t.timestamps
    end
  end
end
