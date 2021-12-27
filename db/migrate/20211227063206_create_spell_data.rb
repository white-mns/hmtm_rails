class CreateSpellData < ActiveRecord::Migration[6.1]
  def change
    create_table :spell_data do |t|
      t.integer :spell_id
      t.string :name
      t.integer :sp
      t.integer :element_id
      t.string :text
      t.integer :range
      t.integer :power
      t.integer :hit
      t.integer :timing_id
      t.integer :class_id

      t.timestamps
    end
  end
end
