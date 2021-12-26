class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :p_no
      t.integer :i_no
      t.string :name
      t.integer :type_id
      t.integer :strength
      t.string :note

      t.timestamps
    end
  end
end
