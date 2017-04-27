class AddHashIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :hash_id, :string, index: true
  end
end
