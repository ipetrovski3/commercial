class BrandsController < ApplicationController
  def index
    @brands = Brand.all
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)
    if @brand.save
      respond_to do |format|
        format.turbo_stream
      end
      redirect_to brands_path
    else
      render :new
    end
  end

  private

  def brand_params
    params.require(:brand).permit(:name).merge(category)
  end

  def category
    {
      category: Category.find(session[:category_id])
    }
  end
end
