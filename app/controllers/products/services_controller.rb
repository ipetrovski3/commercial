class Products::ServicesController < ApplicationController
  def index
    category_id = params[:category_id]
    session[:category_id] = category_id
    @products = Product.joins(pattern: :brand).where(brands: { category_id: category_id })
  end

  def new
    @product = Product.new
    @category = Category.find(session[:category_id])
  end

  def create
    @product = Product.new(product_params)
    # binding.remote_pry
    if @product.save
      set_code = ProductsService.new(@product).generate_code
      @product.update(code: set_code)
      redirect_to products_path
    else
      render :new
    end
  end

  private

  def product_params
    params.permit(:name, :retail_price)
          .merge(pattern_id: create_pattern.id)
  end

  def create_brand
    Brand.find_or_create_by(name: set_brand_name, category_id: session[:category_id])
  end

  def create_pattern
    pattern = Pattern.find_or_create_by(name: set_pattern_name, brand: create_brand)
    # pattern.update(brand_id: create_brand.id)
    pattern
  end

  def set_brand_name
    array = params[:name].split(' ')
    array.first.gsub(/\A\s+|\s+\z/, '')
  end

  def set_pattern_name
    array = params[:name].split(' ')
    array.shift
    array.join(' ')
  end
end
