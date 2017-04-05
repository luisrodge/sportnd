class CreateChallenges < ActiveRecord::Migration[5.0]
  def change
    create_table :challenges do |t|
      t.references :team, foreign_key: true
      t.references :opponent, foreign_key: true
      t.string :type
      t.decimal :wager_amount, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
