class CreateEnrollments < ActiveRecord::Migration[5.0]
  def change
    create_table :enrollments do |t|
      t.references :team, foreign_key: true
      t.references :tournament, foreign_key: true
      t.boolean :organizer

      t.timestamps
    end
  end
end
