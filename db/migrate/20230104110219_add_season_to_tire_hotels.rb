class AddSeasonToTireHotels < ActiveRecord::Migration[7.0]
  def change
    add_column :tire_hotels, :season, :integer
  end
end
