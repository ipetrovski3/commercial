class CreateHotels < ActiveRecord::Migration[7.0]
  def change
    create_table :hotels do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :car_model
      t.string :licence_plate
      t.boolean :with_wheels
      t.date :date_in
      t.date :date_out

      t.timestamps
    end
  end
end
