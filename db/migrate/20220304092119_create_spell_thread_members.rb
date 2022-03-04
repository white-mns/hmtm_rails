class CreateSpellThreadMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :spell_thread_members do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :battle_type
      t.integer :battle_no
      t.integer :turn
      t.integer :thread_id
      t.integer :p_no
      t.string :name

      t.timestamps
    end
  end
end
