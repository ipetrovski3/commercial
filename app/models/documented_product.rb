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

  before_save :set_total_price, if: -> { price.present? && qty.present? }

  validates :product_id, presence: true
  validates :qty, presence: true
  # validates_presence_of :price, unless: -> { documentable_type == 'IssueSlip' }
  # validates_presence_of :total_price, unless: -> { documentable_type == 'IssueSlip' }


  scope :tire_sales, -> { where(documentable_type: 'Invoice') }


  def set_total_price
    self.total_price = price * qty
  end
end
