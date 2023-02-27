class DocumentsController < ApplicationController
  def document_number_by_warehouse
    doc_number = document_number(params[:doc], params[:warehouse_id])
    render json: { document_number: doc_number }
  end

  private

  def document_number(klass, warehouse_id)
    generate_number(klass, warehouse_id)
  end

  def klass_name(klass)
    klass.classify.constantize
  end

  def generate_number(klass, warehouse_id)
    last_doc = klass_name(klass).where(warehouse_id:).last
    current_year = Date.today.strftime('%y')

    return "#{warehouse_id}#{current_year}#{1.to_s.rjust(3, '0')}".to_i if last_doc.nil?

    puts "========================#{last_doc}"
    last_doc_year = last_doc.to_s[1..2]
    if last_doc_year != current_year
      "#{warehouse_id}#{current_year}#{1.to_s.rjust(3, '0')}".to_i
    else
      last_doc.number + 1
    end
  end
end
