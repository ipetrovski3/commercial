class Warehouse < ApplicationRecord
  has_many :stocks, class_name: 'ProductWarehouse', foreign_key: :warehouse_id, dependent: :destroy
  has_many :products, through: :stocks
end
