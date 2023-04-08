class Products::OthersController < ApplicationController
  before_action :set_category, only: [:new, :create, :brands, :patterns]

  def index
    category_id = params[:category_id]
    session[:category_id] = category_id
    @products = Product.joins(brand: :category).where(brands: { category_id: })
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_others_path(category_id: session[:category_id])
    else
      render :new
    end
  end

  def brands
    @brands = @category.brands.where('name ILIKE ?', "%#{params[:q]}%")
    render layout: false
  end

  def patterns
    @patterns = @category.patterns.where('patterns.name ILIKE ?', "%#{params[:q]}%")
    render layout: false
  end

  private

  def product_params
    params.permit(:retail_price, :pattern_id).merge(name:)
  end

  def set_category
    @category = Category.find(session[:category_id])
  end

  def name
    brand_name = Brand.find(params[:brand_id]).name
    pattern_name = Pattern.find(params[:pattern_id]).name
    "#{brand_name} #{pattern_name}"
  end
end
