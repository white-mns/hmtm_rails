class CreateSpells < ActiveRecord::Migration[6.1]
  def change
    create_table :spells do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :p_no
      t.integer :s_no
      t.string :name
      t.integer :sp
      t.integer :power
      t.integer :hit
      t.integer :range
      t.integer :timing_id
      t.integer :spell_id
      t.string :gems

      t.timestamps
    end
  end
end
