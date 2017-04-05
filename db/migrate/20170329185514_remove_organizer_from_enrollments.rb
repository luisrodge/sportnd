class RemoveOrganizerFromEnrollments < ActiveRecord::Migration[5.0]
  def change
  	remove_column :enrollments, :organizer 
  end
end
