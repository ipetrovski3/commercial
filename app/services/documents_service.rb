class DocumentsService
  attr_reader :document

  def initialize(document)
    @document = document
  end

  def call
    update_document
    handle_product_stock
  end

  def update_document
    total_price = document.documents.sum(:total_price)
    net_price = total_price / Invoice::VAT_CALCULATOR
    document.update(total_price: total_price, net_price: net_price)
  end

  def handle_product_stock
    case document.class.name
    when 'Invoice'
      decrease_product_stock
    when 'IncomingInvoice'
      increase_product_stock
    else
      return
    end
  end

  private

  def decrease_product_stock
    document.documents.each do |document|
      document.product.update(stock: document.product.stock - document.qty)
    end
  end

  def increase_product_stock
    document.documents.each do |document|
      document.product.update(stock: document.product.stock + document.qty)
    end
  end
end