class IncomingInvoicesController < ApplicationController
  def index
    @incoming_invoices = IncomingInvoice.all
  end

  def new
    @incoming_invoice = IncomingInvoice.new
    @number = @incoming_invoice.generate_number
    products_fields
  end

  def create
    @incoming_invoice = IncomingInvoice.new(invoice_params)
    if @incoming_invoice.save
      DocumentsService.new(@incoming_invoice).call
      respond_to do |format|
        format.html { redirect_to incoming_invoices_path }
      end
    else
      products_fields
      render :new
    end
  end

  def show
    @incoming_invoice = IncomingInvoice.find(params[:id])
  end

  def edit
    @incoming_invoice = IncomingInvoice.find(params[:id])
    @number = @incoming_invoice.number
    products_fields
  end

  def update
    @incoming_invoice = IncomingInvoice.find(params[:id])
    if @incoming_invoice.update(invoice_params)
      DocumentsService.new(@incoming_invoice).call
      respond_to do |format|
        format.html { redirect_to incoming_invoices_path }
      end
    else
      products_fields
      render :edit
    end
  end

  private

  def products_fields
    60.times { @incoming_invoice.documents.build }
  end

  def invoice_params
    params.require(:incoming_invoice)
          .permit(
            :customer_id,
            :date,
            :number,
            :warehouse_id,
            :incoming_number,
            documents_attributes: %i[id product_id qty price _destroy]
          )
  end
end
