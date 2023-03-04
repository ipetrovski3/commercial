class AddIncomingNumberToIncomingInvoices < ActiveRecord::Migration[7.0]
  def change
    add_column :incoming_invoices, :incoming_number, :string
  end
end
