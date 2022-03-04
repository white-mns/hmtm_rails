class AddIndexToSpellThread < ActiveRecord::Migration[6.1]
  def change
    add_index :spell_threads, [:result_no, :battle_type, :battle_no, :thread_id, :generate_no], :name => 'resultno_battletype_battleno_threadid'
    add_index :spell_threads, :battle_type
    add_index :spell_threads, :battle_no
    add_index :spell_threads, :turn
    add_index :spell_threads, :thread_id
    add_index :spell_threads, :depth
    add_index :spell_threads, :length
  end
end
