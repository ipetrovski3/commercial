class AddWarehouseIdToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_reference :invoices, :warehouse, foreign_key: true
  end
end
