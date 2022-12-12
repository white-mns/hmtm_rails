class AddPageNoToThreadTables < ActiveRecord::Migration[6.1]
  def change
    add_column :spell_threads, :page_no, :integer
    add_column :spell_thread_members, :page_no, :integer
    add_index :spell_threads, :page_no
    add_index :spell_thread_members, :page_no
  end
end
