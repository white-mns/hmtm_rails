class AddIndexToSpellThreadMember < ActiveRecord::Migration[6.1]
  def change
    add_index :spell_thread_members, [:result_no, :battle_type, :battle_no, :thread_id, :generate_no], :name => 'resultno_battletype_battleno_threadid'
    add_index :spell_thread_members, :battle_type
    add_index :spell_thread_members, :battle_no
    add_index :spell_thread_members, :turn
    add_index :spell_thread_members, :thread_id
    add_index :spell_thread_members, :p_no
    add_index :spell_thread_members, :name
  end
end
