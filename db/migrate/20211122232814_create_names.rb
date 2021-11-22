class CreateNames < ActiveRecord::Migration[6.1]
  def change
    create_table :names do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :p_no
      t.string :name
      t.string :player

      t.timestamps
    end
  end
end
