class ReportsController < ApplicationController
  def index
    if params[:start_date].present? && params[:end_date].present?
      @documented_products = DocumentedProduct.joins(product: :brand)
                                              .where(created_at: params[:end_date]..params[:start_date])
                                              .pluck(:product_id, :qty)
    end

    @invoiced_products = Invoice.joins(documents: :product)
                            .where(products: { location: '2055516' })
  end

  def most_sold_products
    DocumentedProduct.group(:product_id)
                     .sum(:qty)
                     .sort_by { |_k, v| v }.reverse
  end

  def by_season
    invoiced_products_by_season = Invoice.joins(documents: [{ product: :pattern }])
                                     .group('patterns.season')
                                     .count
  end

  def most_sold_brands
    Product.joins(:brand).where(id: product_ids).group(:brand_id).count
  end

  def by_pattern
    Product.joins(:pattern).where(id: product_ids).group(:pattern_id).count
  end

  def product_ids
    most_sold_products.map(&:first)
  end
end
