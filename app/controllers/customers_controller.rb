class CustomersController < ApplicationController
  def index
    if params[:customer_id].present?
      @customer = Customer.find(params[:customer_id])
      render json: @customer
    end
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to customers_path
    else
      render :new
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customers_path
    else
      render :edit
    end
  end

  def invoiced
    # binding.remote_pry
    @customers = Customer.where('name ILIKE ?', "%#{params[:q]}%")
    render layout: false
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :address, :phone, :edb, :emb, :due, :customer_type, :email)
  end
end
