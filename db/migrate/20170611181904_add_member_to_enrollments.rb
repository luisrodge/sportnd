class AddMemberToEnrollments < ActiveRecord::Migration[5.0]
  def change
    add_column :enrollments, :member_id, :integer, index:true, foreign_key:true
  end
end
