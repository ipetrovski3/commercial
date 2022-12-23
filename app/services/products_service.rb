class ProductsService
  attr_reader :product, :dimension

  def initialize(product)
    @product = product
    @dimension = product.dimension
  end

  def call
    product.update(code: code, name: name, location: location)
  end

  def location
    dimension.gsub(/[^\d]/, '')
  end

  def code
    brand_code = product.pattern.brand.id.to_s.rjust(2, '0')
    pattern_code = product.pattern.id.to_s.rjust(2, '0')
    product_code = Product.where(pattern_id: product.pattern.id).count.to_s.rjust(2, '0')
    "#{brand_code}#{pattern_code}#{product_code}"
  end

  def name
    "#{product.brand_name} #{product.pattern_name}"
  end
end
