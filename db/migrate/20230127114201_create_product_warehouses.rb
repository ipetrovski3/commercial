class CreateProductWarehouses < ActiveRecord::Migration[7.0]
  def change
    create_table :product_warehouses do |t|
      t.references :product, null: false, foreign_key: true
      t.references :warehouse, null: false, foreign_key: true
      t.integer :stock

      t.timestamps
    end
  end
end
