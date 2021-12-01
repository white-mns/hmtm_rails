class CreateEquips < ActiveRecord::Migration[6.1]
  def change
    create_table :equips do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :p_no
      t.integer :equip_no
      t.string :name
      t.integer :range
      t.integer :strength_1
      t.integer :strength_2
      t.string :note

      t.timestamps
    end
  end
end
