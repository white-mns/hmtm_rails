class CreateProperNames < ActiveRecord::Migration[6.1]
  def change
    create_table :proper_names do |t|
      t.integer :proper_id
      t.string :name

      t.timestamps
    end
  end
end
