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

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to customers_path
  end

  def invoiced
    # binding.remote_pry
    @customers = Customer.where('name ILIKE ?', "%#{params[:q]}%").or(Customer.where(id: params[:q]))
    render layout: false
  end

  def list
    direction = params[:direction]
    customers = if params[:column] == 'total'
                  Customer.joins(:invoices).group('customers.id').order("sum(invoices.total_price) #{direction}")
                else
                  Customer.all.order("#{params[:column]} #{direction}")
                end
    render(partial: 'customers', locals: { customers: })
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :address, :phone, :edb, :emb, :due, :customer_type, :email)
  end
end
