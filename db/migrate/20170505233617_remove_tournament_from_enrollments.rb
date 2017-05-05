class RemoveTournamentFromEnrollments < ActiveRecord::Migration[5.0]
  def change
    remove_column :enrollments, :tournament
  end
end
