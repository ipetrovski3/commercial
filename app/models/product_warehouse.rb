class ProductWarehouse < ApplicationRecord
  belongs_to :product
  belongs_to :warehouse

  default_scope { where('stock > 0').or(where('stock < 0')) }
  scope :positive, -> { where('stock > 0') }

  def next
    product.stocks.where('id > ?', id).first
  end
end
