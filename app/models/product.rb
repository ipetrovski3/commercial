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

  acts_as_paranoid

  belongs_to :pattern
  has_one :brand, through: :pattern

  has_many :stocks, class_name: 'ProductWarehouse', foreign_key: :product_id
  has_many :warehouses, through: :stocks

  has_many :documented_products, foreign_key: :product_id, class_name: 'DocumentedProduct'
  has_many :invoices, through: :documented_products, source: :documentable, source_type: 'Invoice'

  delegate :name, to: :pattern, prefix: true
  delegate :name, to: :brand, prefix: true

  scope :winter_season, -> { includes(:pattern).where(patterns: { season: 'winter' }) }
  scope :summer_season, -> { includes(:pattern).where(patterns: { season: 'summer' }) }
  scope :all_season, -> { includes(:pattern).where(patterns: { season: 'all_season' }) }

  scope :tires, -> { joins(:brand).where('brands.category_id = ?', Category.find_by(name: 'Гуми').id) }

  enum vat: { '18%' => 18, '5%' => 5, '0%' => 0 }

  def display_name
    "#{dimension} #{name}"
  end

  def stock_per_warehouse(warehouse)
    stocks.where(warehouse_id: warehouse.id).sum(:stock)
  end

  def summed_stock
    stocks.sum(:stock)
  end

  def total_qty_invoiced
    DocumentedProduct.tire_sales.where(product_id: id).sum(:qty)
  end

  def stockable?
    brand.category.goods?
  end

end
