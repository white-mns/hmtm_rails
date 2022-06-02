class AddIndexToRaidReward < ActiveRecord::Migration[6.1]
  def change
    add_index :raid_rewards, [:result_no, :p_no, :generate_no], :name => 'resultno_pno'
    add_index :raid_rewards, :sc
    add_index :raid_rewards, :tp
    add_index :raid_rewards, :rp
  end
end
