class CreateEnrollments < ActiveRecord::Migration[5.0]
  def change
    create_table :enrollments do |t|
      t.integer :team, foreign_key: true
      t.integer :tournament, foreign_key: true
      t.boolean :organizer

      t.timestamps
    end
  end
end
