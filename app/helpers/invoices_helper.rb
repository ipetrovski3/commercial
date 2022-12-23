module InvoicesHelper
  def input_class
    'block border border-gray-200 rounded px-3 py-2 leading-6 focus:border-blue-500 focus:ring focus:ring-blue-500 focus:ring-opacity-50'
  end

  def invoices_this_month
    Invoice.where(date: Date.today.beginning_of_month..Date.today.end_of_month).count
  end

  def incoming_invoces_this_month
    IncomingInvoice.where(date: Date.today.beginning_of_month..Date.today.end_of_month).count
  end
end
