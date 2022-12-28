# == Schema Information
#
# Table name: products
#
#  id           :bigint           not null, primary key
#  dimension    :string
#  name         :string
#  code         :string
#  location     :string
#  stock        :integer
#  retail_price :string
#  pattern_id   :bigint
#  vat          :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Product < ApplicationRecord
  belongs_to :pattern
  has_one :brand, through: :pattern

  has_many :documented_products, foreign_key: :product_id, class_name: 'DocumentedProduct', dependent: :destroy
  has_many :invoices, through: :documented_products, source: :documentable, source_type: 'Invoice'

  delegate :name, to: :pattern, prefix: true
  delegate :name, to: :brand, prefix: true

  scope :positive_stock, -> { where('stock > 0') }

  scope :winter_season, -> { includes(:pattern).where(patterns: { season: 'winter' }) }
  scope :summer_season, -> { includes(:pattern).where(patterns: { season: 'summer' }) }
  scope :all_season, -> { includes(:pattern).where(patterns: { season: 'all_season' }) }

  scope :tires, -> { joins(:brand).where('brands.category_id = ?', Category.find_by(name: 'Гуми').id) }

  enum vat: { '18%' => 18, '5%' => 5, '0%' => 0 }

  def display_name
    "#{dimension} #{name}"
  end

  def total_qty_invoiced
    DocumentedProduct.tire_sales.where(product_id: id).sum(:qty)
  end
end
