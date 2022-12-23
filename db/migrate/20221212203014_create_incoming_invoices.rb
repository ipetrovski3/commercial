class CreateIncomingInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :incoming_invoices do |t|
      t.references :customer, foreign_key: true
      t.integer 'number'
      t.date 'date'
      t.float 'net_price'
      t.float 'vat'
      t.float 'total_price'
      t.timestamps
    end
  end
end
