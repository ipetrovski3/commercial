class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :dimension
      t.string :name
      t.string :code
      t.string :location
      t.integer :stock, default: 0
      t.string :retail_price
      t.references :pattern, foreign_key: true
      t.integer :vat
      t.timestamps
    end
  end
end
