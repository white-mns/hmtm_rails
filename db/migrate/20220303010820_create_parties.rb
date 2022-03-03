class CreateParties < ActiveRecord::Migration[6.1]
  def change
    create_table :parties do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :p_no
      t.integer :party_type
      t.integer :party_no
      t.integer :is_supporter

      t.timestamps
    end
  end
end
