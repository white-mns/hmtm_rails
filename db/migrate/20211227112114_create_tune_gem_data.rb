class CreateTuneGemData < ActiveRecord::Migration[6.1]
  def change
    create_table :tune_gem_data do |t|
      t.integer :tg_id
      t.string :name
      t.string :sp
      t.integer :type_id
      t.string :text

      t.timestamps
    end
  end
end
