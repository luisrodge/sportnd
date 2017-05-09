class RemoveUsernameAndProfileImageAndFullNameAndHashIdFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :full_name
    remove_column :users, :profile_image
    remove_column :users, :hash_id
    remove_column :users, :username
  end
end
