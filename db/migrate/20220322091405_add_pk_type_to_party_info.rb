class AddPkTypeToPartyInfo < ActiveRecord::Migration[6.1]
  def change
    add_column :party_infos, :pk_type, :integer
    add_index  :party_infos, :pk_type
  end
end
