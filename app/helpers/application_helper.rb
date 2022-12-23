module ApplicationHelper

  def pdf_document_type
    case controller_name
    when 'invoices'
      'Фактура'
    when 'incoming_invoices'
      'IncomingInvoice'
    else
      return
    end
  end

  
end
