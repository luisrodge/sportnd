class RemoveOrganizerIdFromTournaments < ActiveRecord::Migration[5.0]
  def change
  	remove_column :tournaments, :organizer_id 
  end
end
