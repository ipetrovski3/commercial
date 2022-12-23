class AddTotalPriceToDocumentedProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :documented_products, :total_price, :float
  end
end
