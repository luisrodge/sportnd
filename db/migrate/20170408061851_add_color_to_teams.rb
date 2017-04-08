class AddColorToTeams < ActiveRecord::Migration[5.0]
  def change
    add_reference :teams, :color, foreign_key: true
  end
end
