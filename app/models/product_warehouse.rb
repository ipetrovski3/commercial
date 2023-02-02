class ProductWarehouse < ApplicationRecord
  belongs_to :product
  belongs_to :warehouse

  # default scope where stock > 0 because when decreasing from stock we don't want to decrease from 0
  default_scope { where('stock > 0').or(where('stock < 0')) }
  scope :positive, -> { where('stock > 0') }
  # def only_positve
  #   where('stock > 0')
  # end

  def next
    product.stocks.where('id > ?', id).first
  end
end
