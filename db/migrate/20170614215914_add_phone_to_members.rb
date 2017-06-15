class AddPhoneToMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :members, :phone, :string
  end
end
