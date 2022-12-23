class IncomingInvoicesController < ApplicationController
  def index
    @incoming_invoices = IncomingInvoice.all
  end

  def new
    @incoming_invoice = IncomingInvoice.new
    @number = @incoming_invoice.generate_number
    60.times { @incoming_invoice.documents.build }
  end

  def create
    @incoming_invoice = IncomingInvoice.new(invoice_params)
    if @incoming_invoice.save
      DocumentsService.new(@incoming_invoice).call
      respond_to do |format|
        format.html { redirect_to invoices_path }
      end
    else
      render :new
    end
  end

  private

  def invoice_params
    params.require(:incoming_invoice)
          .permit(
            :customer_id,
            :date,
            :number,
            documents_attributes: %i[id product_id qty price _destroy]
          )
  end
end
