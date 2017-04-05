class AddOrganizerToEnrollments < ActiveRecord::Migration[5.0]
  def change
    add_column :enrollments, :organizer, :boolean
  end
end
