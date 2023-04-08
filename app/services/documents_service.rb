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
    vat = total_price - net_price
    document.update(total_price:, net_price:, vat:)
  end

  def handle_product_stock
    case document.class.name
    when 'Invoice'
      decrease_product_stock
    when 'IncomingInvoice'
      increase_product_stock
    end
  end

  private

  def decrease_product_stock
    document.documents.each do |document|
      next unless document.product.stockable?

      product = document.product
      product_warehouse = ProductWarehouse.positive.where(product: product, warehouse: warehouse).first
      # product.stocks.positive.find_by(warehouse_id: warehouse.id)
      product_warehouse = product.stocks.where(warehouse: warehouse).last if product_warehouse.nil?
      product_warehouse.update(stock: product_warehouse.stock - document.qty)
      check_for_negative_stock(product_warehouse, product)
    end
  end

  def increase_product_stock
    document.documents.each do |document|
      next unless document.product.stockable?

      ProductWarehouse.create(
        product: document.product,
        warehouse: warehouse,
        stock: document.qty
      )
    end
  end

  def warehouse
    @warehouse ||= Warehouse.find(document.warehouse_id)
  end

  def check_for_negative_stock(product_warehouse, product)
    product_stock = product_warehouse.stock
    return unless product_stock.negative?

    product_warehouse.update(stock: 0)
    product_warehouse.next.update(stock: product_warehouse.next.stock + product_stock)
  end

  def only_stockable_products
    document.documents.select { |document| document.product.stockable? }
  end
end
