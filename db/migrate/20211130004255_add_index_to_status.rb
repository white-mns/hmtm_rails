class AddIndexToStatus < ActiveRecord::Migration[6.1]
  def change
    add_index :statuses, [:result_no, :p_no, :generate_no], :name => 'resultno_pno'
    add_index :statuses, :mhp
    add_index :statuses, :mmp
    add_index :statuses, :msp
    add_index :statuses, :cp
    add_index :statuses, :str
    add_index :statuses, :def
    add_index :statuses, :tec
    add_index :statuses, :eva
    add_index :statuses, :agi
    add_index :statuses, :luk
    add_index :statuses, :cha
    add_index :statuses, :rank_id
    add_index :statuses, :tp
    add_index :statuses, :ap
    add_index :statuses, :pp
    add_index :statuses, :sc
  end
end
