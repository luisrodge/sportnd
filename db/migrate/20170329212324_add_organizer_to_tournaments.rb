class AddOrganizerToTournaments < ActiveRecord::Migration[5.0]
  def change
    add_reference :tournaments, :organizer, foreign_key: true
  end
end
