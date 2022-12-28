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
end
