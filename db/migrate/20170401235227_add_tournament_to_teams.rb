class AddTournamentToTeams < ActiveRecord::Migration[5.0]
  def change
    add_reference :teams, :tournament, foreign_key: true
  end
end
