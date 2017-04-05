class CreateTournaments < ActiveRecord::Migration[5.0]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.integer :capacity
      t.references :venue, foreign_key: true
      t.references :sport, foreign_key: true
      t.string :status, :default => "enroll"
      t.datetime :date
      t.decimal :bet_amount, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
