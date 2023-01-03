class Products::OthersController < ApplicationController
  def index
    category_id = params[:category_id]
    session[:category_id] = category_id
    @products = Product.joins(brand: :category).where(brands: { category_id: })
  end

  def new
    @product = Product.new
    @category = Category.find(session[:category_id])
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :retail_price, :pattern_id)
  end
end
