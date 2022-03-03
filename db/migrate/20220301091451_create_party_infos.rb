class CreatePartyInfos < ActiveRecord::Migration[6.1]
  def change
    create_table :party_infos do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :party_type
      t.integer :party_no
      t.string :name
      t.integer :member_num
      t.integer :attacker_num
      t.integer :supporter_num

      t.timestamps
    end
  end
end
