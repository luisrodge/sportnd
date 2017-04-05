class AddTeamSizeToTournaments < ActiveRecord::Migration[5.0]
  def change
    add_column :tournaments, :team_size, :integer
  end
end
