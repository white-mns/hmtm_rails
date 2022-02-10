class AddIndexToTuningAbility < ActiveRecord::Migration[6.1]
  def change
    add_index :tuning_abilities, [:result_no, :p_no, :generate_no], :name => 'resultno_pno'
    add_index :tuning_abilities, :s_no
    add_index :tuning_abilities, :name
    add_index :tuning_abilities, :merit_id
    add_index :tuning_abilities, :merit_value
    add_index :tuning_abilities, :demerit_id
    add_index :tuning_abilities, :demerit_value
  end
end
