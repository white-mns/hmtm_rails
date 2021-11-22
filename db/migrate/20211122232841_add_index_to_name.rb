class AddIndexToName < ActiveRecord::Migration[6.1]
  def change
    add_index :names, [:result_no, :p_no, :generate_no], :unique => false, :name => 'resultno_pno'
  end
end
