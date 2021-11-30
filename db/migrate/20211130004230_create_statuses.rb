class CreateStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :statuses do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :p_no
      t.integer :mhp
      t.integer :mmp
      t.integer :msp
      t.integer :cp
      t.integer :str
      t.integer :def
      t.integer :tec
      t.integer :eva
      t.integer :agi
      t.integer :luk
      t.integer :cha
      t.integer :rank_id
      t.integer :tp
      t.integer :ap
      t.integer :pp
      t.integer :sc

      t.timestamps
    end
  end
end
