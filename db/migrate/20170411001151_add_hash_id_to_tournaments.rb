class AddHashIdToTournaments < ActiveRecord::Migration[5.0]
  def change
    add_column :tournaments, :hash_id, :string, index: true
  end
end
