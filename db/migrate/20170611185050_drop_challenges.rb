class DropChallenges < ActiveRecord::Migration[5.0]
  def change
    drop_table :challenges
  end
end
