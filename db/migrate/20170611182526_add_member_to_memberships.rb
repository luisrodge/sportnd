class AddMemberToMemberships < ActiveRecord::Migration[5.0]
  def change
    add_column :memberships, :member_id, :integer, index:true, foreign_key:true
  end
end
