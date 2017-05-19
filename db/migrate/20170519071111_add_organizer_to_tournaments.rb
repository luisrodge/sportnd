class AddOrganizerToTournaments < ActiveRecord::Migration[5.0]
  def change
    add_column :tournaments, :organizer_id, :integer, foreign_key: true
  end
end
