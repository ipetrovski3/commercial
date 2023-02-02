class AddWarehouseReferenceToAllDocumentModels < ActiveRecord::Migration[7.0]
  def change
    add_reference :incoming_invoices, :warehouse, index: true
    add_reference :issue_slips, :warehouse, index: true

    2.times do |i|
      Warehouse.create(name: "Магацин #{i}")
    end

    remove_column :products, :stock
  end
end
