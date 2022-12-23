class AddExtraFieldsToDocumentedProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :documented_products, :qty, :integer
    add_column :documented_products, :price, :float
  end
end
