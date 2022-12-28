class Products::ServicesController < ApplicationController
  # before_action :category_id, only: :index

  def index
    category_id = params[:category_id]
    @products = Product.joins(pattern: :brand).where(brands: { category_id: category_id })
    session[:category_id] = category_id
  end

  def new
    @product = Product.new
    @category_id = session[:category_id]
  end

  def create
    @product = Product.new(product_params)
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :category_id)
  end

end
