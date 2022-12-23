class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.references :customer, foreign_key: true
      t.integer :number
      t.date :date
      t.float :net_price
      t.float :vat
      t.float :total_price
      t.string :received_by
      t.string :licence_plate

      t.timestamps
    end
  end
end
