class AddOmniauthToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :uid, :string, index: true
    add_column :users, :name, :string
    add_column :users, :image, :text
    add_column :users, :location, :string
    add_column :users, :oauth_token, :string
    add_column :users, :oauth_expires_at, :datetime
    add_column :users, :provider, :string
  end
end
