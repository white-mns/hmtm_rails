class AddIndexToPartyInfo < ActiveRecord::Migration[6.1]
  def change
    add_index :party_infos, [:result_no, :party_no, :generate_no], :name => 'resultno_partyno'
    add_index :party_infos, :party_type
    add_index :party_infos, :name
    add_index :party_infos, :member_num
    add_index :party_infos, :attacker_num
    add_index :party_infos, :supporter_num
  end
end
