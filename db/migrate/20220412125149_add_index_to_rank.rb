class AddIndexToRank < ActiveRecord::Migration[6.1]
  def change
    add_index :ranks, [:result_no, :p_no, :generate_no], :name => 'resultno_pno'
    add_index :ranks, :rp
    add_index :ranks, :total_match_num
    add_index :ranks, :total_win_num
    add_index :ranks, :total_draw_num
    add_index :ranks, :total_lose_num
  end
end
