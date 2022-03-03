class AddIndexToParty < ActiveRecord::Migration[6.1]
  def change
    add_index :parties, [:result_no, :p_no, :generate_no], :name => 'resultno_pno'
    add_index :parties, [:result_no, :party_no, :generate_no], :name => 'resultno_partyno'
    add_index :parties, :party_type
    add_index :parties, :is_supporter
  end
end
