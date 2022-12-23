class CreateTireDimensions < ActiveRecord::Migration[7.0]
  def change
    create_table :tire_dimensions do |t|
      t.string :dimension

      t.timestamps
    end
  end
end
