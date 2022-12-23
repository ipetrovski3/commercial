class AddDueDaysToInvoice < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :due_days, :integer, default: 0
  end
end
