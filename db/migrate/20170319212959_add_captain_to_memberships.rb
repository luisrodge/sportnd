class AddCaptainToMemberships < ActiveRecord::Migration[5.0]
  def change
    add_column :memberships, :captain, :boolean
  end
end
