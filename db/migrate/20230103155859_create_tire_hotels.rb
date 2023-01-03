class CreateTireHotels < ActiveRecord::Migration[7.0]
  def change
    create_table :tire_hotels do |t|
      t.references :hotel, null: false, foreign_key: true
      t.string :tire
      t.integer :qty

      t.timestamps
    end
  end
end
