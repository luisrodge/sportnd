class RemoveColorFromTeams < ActiveRecord::Migration[5.0]
  def change
    remove_column :teams, :color
  end
end
