class CreateDocumentedProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :documented_products do |t|
      t.string :documentable_type
      t.integer :documentable_id
      t.references :product, foreign_key: true
      t.timestamps
    end
  end
end
