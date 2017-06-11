class DropColorations < ActiveRecord::Migration[5.0]
  def change
    drop_table :colorations
  end
end
