class AddTimeToTournaments < ActiveRecord::Migration[5.0]
  def change
    add_column :tournaments, :time, :time
  end
end
