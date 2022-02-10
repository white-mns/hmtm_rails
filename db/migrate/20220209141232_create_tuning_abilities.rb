class CreateTuningAbilities < ActiveRecord::Migration[6.1]
  def change
    create_table :tuning_abilities do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :p_no
      t.integer :s_no
      t.string :name
      t.integer :merit_id
      t.integer :merit_value
      t.integer :demerit_id
      t.integer :demerit_value

      t.timestamps
    end
  end
end
