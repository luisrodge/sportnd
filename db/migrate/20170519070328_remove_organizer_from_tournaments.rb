class RemoveOrganizerFromTournaments < ActiveRecord::Migration[5.0]
  def change
    remove_column :tournaments, :organizer

  end
end
