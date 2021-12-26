class AddIndexToItem < ActiveRecord::Migration[6.1]
  def change
    add_index :items, [:result_no, :p_no, :generate_no], :name => 'resultno_pno'
    add_index :items, :i_no
    add_index :items, :name
    add_index :items, :type_id
    add_index :items, :strength
    add_index :items, :note
  end
end
