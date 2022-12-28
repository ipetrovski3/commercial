class Products::OthersController < ApplicationController
  def index
    @products = Product.where(category_id: category_id)
    session[:category] = category_id
  end

  def new
    @product = Product.new
    @category = session[:category_id]
  end

  private

  def category
    @category ||= Category.find(params[:category_id])
  end

  def product_params
    params.require(:product).permit(:name, :price).merge(category_id: category_id)
  end
end
