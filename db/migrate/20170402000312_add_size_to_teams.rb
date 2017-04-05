class AddSizeToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :size, :integer
  end
end
