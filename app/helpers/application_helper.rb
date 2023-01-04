module ApplicationHelper
  include Pagy::Frontend

  def categories
    Category.all
  end

  def get_brand_by_category(category_id)
    Brand.where(category_id: category_id)
  end

  def pdf_document_type
    case controller_name
    when 'invoices'
      'Фактура'
    when 'incoming_invoices'
      'IncomingInvoice'
    when 'issue_slips'
      'Испратница'
    else
      return
    end
  end

  def products_routes(cat_name, cat_id)
    case cat_name
    when 'Гуми'
      products_tires_path(category_id: cat_id)
    when 'Услуги'
      products_services_path(category_id: cat_id)
    else
      products_others_path(category_id: cat_id)
    end
  end

  def icon(name)
    case name
    when 'Гуми'
      content_tag(:i, '', class: 'fa-solid fa-cookie')
    when 'Услуги'
      content_tag(:i, '', class: 'fa-solid fa-tools')
    when 'Моторно Масло'
      content_tag(:i, '', class: 'fa-solid fa-oil-can')
    when 'Козметика'
      content_tag(:i, '', class: 'fa-solid fa-tree')
    when 'Вулканизерска Опрема'
      content_tag(:i, '', class: 'fa-solid fa-toolbox')
    else
      content_tag(:i, '', class: 'fa-solid fa-box')
    end
  end

  def document_show_route(action, controller_name, document, format = 'html')
    case controller_name
    when 'invoices'
      if action == 'show'
        invoice_path(document, format: format)
      elsif action == 'edit'
        edit_invoice_path(document, format: format)
      end
    when 'incoming_invoices'
      if action == 'show'
        incoming_invoice_path(document, format: format)
      elsif action == 'edit'
        edit_incoming_invoice_path(document, format: format)
      end
    when 'issue_slips'
      if action == 'show'
        issue_slip_path(document, format: format)
      elsif action == 'edit'
        edit_issue_slip_path(document, format: format)
      end
    else
      return
    end
  end
end
