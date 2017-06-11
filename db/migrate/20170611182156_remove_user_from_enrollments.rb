class RemoveUserFromEnrollments < ActiveRecord::Migration[5.0]
  def change
    remove_column :enrollments, :user_id
  end
end
