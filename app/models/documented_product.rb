# == Schema Information
#
# Table name: documented_products
#
#  id                :bigint           not null, primary key
#  documentable_type :string
#  documentable_id   :integer
#  product_id        :bigint
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  qty               :integer
#  price             :float
#  total_price       :float
#
class DocumentedProduct < ApplicationRecord
  belongs_to :product
  belongs_to :documentable, polymorphic: true

  before_save :set_total_price

  scope :tire_sales, -> { where(documentable_type: 'Invoice') }

  def set_total_price
    self.total_price = price * qty
  end
end
