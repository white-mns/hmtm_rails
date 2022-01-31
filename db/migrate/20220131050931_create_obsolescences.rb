class CreateObsolescences < ActiveRecord::Migration[6.1]
  def change
    create_table :obsolescences do |t|
      t.integer :result_no
      t.integer :generate_no
      t.string :gems
      t.integer :gem_num
      t.decimal :obsolescence, precision:8, scale: 1

      t.timestamps
    end
  end
end
