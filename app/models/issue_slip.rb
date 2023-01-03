class IssueSlip < ApplicationRecord
  belongs_to :customer
  belongs_to :invoice, optional: true

  has_many :documents, as: :documentable, class_name: 'DocumentedProduct', dependent: :destroy
  has_many :products, through: :documents, foreign_key: :product_id

  accepts_nested_attributes_for :documents, allow_destroy: true, reject_if: :all_blank

  scope :uninvoiced, -> { where(invoice_id: nil) }
  scope :invoiced, -> { where.not(invoice_id: nil) }

  def total
    products.sum(:price)
  end

  def invoiced?
    invoice_id.present?
  end
end