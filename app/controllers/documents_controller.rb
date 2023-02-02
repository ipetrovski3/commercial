class DocumentsController < ApplicationController
  def document_number_by_warehouse
    document_type = params[:doc].capitalize
    document = document_type.classify.constantize
    doc_number = document.where(warehouse_id: params[:warehouse_id]).count + 1

    year = Date.today.strftime('%y')
    document_number = "#{year}#{doc_number.to_s.rjust(3, '0')}".to_i
    render json: { document_number: }
  end
end
