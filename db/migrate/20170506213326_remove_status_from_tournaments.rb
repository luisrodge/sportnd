class RemoveStatusFromTournaments < ActiveRecord::Migration[5.0]
  def change
    remove_column :tournaments, :status 
  end
end
