class CreateRanks < ActiveRecord::Migration[6.1]
  def change
    create_table :ranks do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :p_no
      t.integer :rp
      t.integer :total_match_num
      t.integer :total_win_num
      t.integer :total_draw_num
      t.integer :total_lose_num

      t.timestamps
    end
  end
end
