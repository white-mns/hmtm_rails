class CreateSpellThreads < ActiveRecord::Migration[6.1]
  def change
    create_table :spell_threads do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :battle_type
      t.integer :battle_no
      t.integer :turn
      t.integer :thread_id
      t.text :thread
      t.text :thread_tg
      t.text :thread_orig
      t.text :thread_orig_tg
      t.text :thread_base
      t.text :thread_base_tg
      t.integer :depth
      t.integer :length

      t.timestamps
    end
  end
end
