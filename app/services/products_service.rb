class ProductsService
  attr_reader :product, :dimension

  def initialize(product)
    @product = product
    @dimension = product.dimension
  end

  def call
    product.update(code: generate_code, name: set_name, location: set_location)
  end

  def set_location
    return dimension.gsub(/[^\d]/, '') if dimension.present?
  end

  def generate_code
    brand_code = product.pattern.brand.id.to_s.rjust(2, '0')
    pattern_code = product.pattern.id.to_s.rjust(2, '0')
    product_code = pattern_products_count.to_s.rjust(2, '0')
    "#{brand_code}#{pattern_code}#{product_code}"
  end

  def set_name
    "#{product.brand_name} #{product.pattern_name}"
  end

  def pattern_products_count
    pattern = product.pattern
    pattern.products.count
  end
end
