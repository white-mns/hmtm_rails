class AddIndexToTuneGemData < ActiveRecord::Migration[6.1]
  def change
    add_index :tune_gem_data, :tg_id
    add_index :tune_gem_data, :name
    add_index :tune_gem_data, :sp
    add_index :tune_gem_data, :type_id
    add_index :tune_gem_data, :text
  end
end
