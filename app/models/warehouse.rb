class Warehouse < ApplicationRecord
  has_many :stocks, class_name: 'ProductWarehouse', foreign_key: :warehouse_id, dependent: :delete_all
  has_many :products, through: :stocks, dependent: :destroy
  has_many :incoming_invoices, dependent: :destroy
  has_many :invoices, dependent: :destroy
end
