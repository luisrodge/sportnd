class RemoveUserFromMemberships < ActiveRecord::Migration[5.0]
  def change
    remove_column :memberships, :user_id
  end
end
