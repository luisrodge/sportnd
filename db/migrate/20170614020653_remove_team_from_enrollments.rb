class RemoveTeamFromEnrollments < ActiveRecord::Migration[5.0]
  def change
    remove_column :enrollments, :team_id
  end
end
