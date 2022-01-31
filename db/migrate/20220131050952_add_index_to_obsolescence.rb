class AddIndexToObsolescence < ActiveRecord::Migration[6.1]
  def change
    add_index :obsolescences, [:result_no, :generate_no], :name => 'resultno_generateno'
    add_index :obsolescences, :gems
    add_index :obsolescences, :gem_num
    add_index :obsolescences, :obsolescence
  end
end
