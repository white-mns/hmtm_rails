class AddIndexToPkPkk < ActiveRecord::Migration[6.1]
  def change
    add_index :pk_pkks, [:result_no, :p_no, :generate_no], :name => 'resultno_pno'
    add_index :pk_pkks, :pvp_type
    add_index :pk_pkks, :total_match_num
    add_index :pk_pkks, :total_battle_num
    add_index :pk_pkks, :total_cheer_num
    add_index :pk_pkks, :total_win_num
    add_index :pk_pkks, :total_draw_num
    add_index :pk_pkks, :total_lose_num
    add_index :pk_pkks, :total_income
    add_index :pk_pkks, :last_announcement_result_no
  end
end
