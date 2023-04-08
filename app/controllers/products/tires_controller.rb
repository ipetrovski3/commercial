module Products
  class TiresController < ApplicationController
    def index
      session[:category_id] = params[:category_id]
      Rails.logger.info "TiresController#index #{session[:category_id]}]}"
      @pagy, @tires = pagy(Product.tires)
    end

    def new
      category = Category.find_by(name: 'Гуми')
      @brands = category.brands
      @tire = Product.new
    end

    def create
      @tire = Product.new(tire_params)

      if @tire.save
        ProductsService.new(@tire).call
        redirect_to products_path
      else
        render :new
      end
    end

    def edit
      @tire = Product.find(params[:id])
    end

    def update
      @tire = Product.find(params[:id])
      if @tire.update(tire_params)
        redirect_to products_path
      else
        render :edit
      end
    end

    def dimensions
      @dimensions = TireDimension.where('dimension ILIKE ?', "%#{params[:q]}%")
      render layout: false
    end

    def brands
      @brands = Brand.where('name ILIKE ?', "%#{params[:q]}%")
      render layout: false
    end

    def patterns
      @patterns = Pattern.where('name ILIKE ?', "%#{params[:q]}%")
      render layout: false
    end

    private

    def tire_params
      params.permit(:name, :retail_price, :location, :pattern_id, :dimension, :vat)
    end
  end
end
