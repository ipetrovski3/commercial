class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  # GET /products or /products.json
  def index
    if params[:product_id].present?
      @product = Product.find(params[:product_id])
      render json: @product
    end

    @products = if params[:location].present?
                  p = Product.where(location: params[:location]).positive_stock
                  if params[:seasons].present?
                    p.includes(:pattern).where(patterns: { season: params[:seasons] })
                  else
                    p
                  end
                elsif params[:seasons].present?
                  Product.includes(:pattern).where(patterns: { season: params[:seasons] })
                else
                  Product.positive_stock
                end
  end

  # GET /products/1 or /products/1.json
  def show; end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit; end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    if @product.save
      ProductsService.new(@product).call
      redirect_to products_path, notice: 'Product was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def brands
    @target = params[:target]
    @patterns = Brand.find(params[:brand]).patterns.pluck(:name, :id)
    respond_to do |format|
      format.turbo_stream
    end
  end

  def search
    @products = Product.where(location: params[:location])
  end

  def invoiced
    @products = Product.where('dimension ILIKE ?', "%#{params[:q]}%").or(Product.where(location: params[:name]))
    render layout: false
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product)
          .permit(
            :retail_price,
            :pattern_id,
            :vat,
            :dimension
          )
  end
end
