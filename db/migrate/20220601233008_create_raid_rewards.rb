class CreateRaidRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :raid_rewards do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :p_no
      t.integer :sc
      t.integer :tp
      t.integer :rp

      t.timestamps
    end
  end
end
