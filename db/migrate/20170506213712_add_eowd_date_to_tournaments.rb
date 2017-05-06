class AddEowdDateToTournaments < ActiveRecord::Migration[5.0]
  def change
    add_column :tournaments, :eowd_date, :date
  end
end
