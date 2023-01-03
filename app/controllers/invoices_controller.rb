class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def new
    @invoice = Invoice.new
    @number = @invoice.generate_invoice_number
    10.times { @invoice.documents.build }
  end

  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      DocumentsService.new(@invoice).call
      redirect_to invoices_path
    else
      build_location
      render :new
    end
  end

  def edit
    @invoice = Invoice.find(params[:id])
    @number = @invoice.number
    build_location
  end

  def update
    @invoice = Invoice.find(params[:id])
    if @invoice.update(invoice_params)
      DocumentsService.new(@invoice).call
      redirect_to invoices_path
    else
      build_location
      render :edit
    end
  end

  def show
    @invoice = Invoice.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "invoice_#{params[:id]}",
               template: 'invoices/pdf',
               layout: 'pdf',
               formats: [:html],
               encoding: 'UTF-8'
      end
    end
  end

  private

  def invoice_params
    params.require(:invoice)
          .permit(
            :customer_id,
            :date,
            :number,
            :received_by,
            :licence_plate,
            documents_attributes: %i[id product_id qty price _destroy]
          )
  end

  def build_location
    10.times { @invoice.documents.build }
  end
end
