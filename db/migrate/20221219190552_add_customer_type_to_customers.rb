class AddCustomerTypeToCustomers < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :customer_type, :integer, default: 0
    add_column :customers, :email, :string
  end
end
