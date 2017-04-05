class AddUserToEnrollments < ActiveRecord::Migration[5.0]
  def change
    add_reference :enrollments, :user, foreign_key: true
  end
end
