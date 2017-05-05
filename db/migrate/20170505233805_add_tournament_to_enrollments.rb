class AddTournamentToEnrollments < ActiveRecord::Migration[5.0]
  def change
    add_column :enrollments, :tournament_id, :integer, foreign_key: true
  end
end
