# == Schema Information
#
# Table name: incoming_invoices
#
#  id          :bigint           not null, primary key
#  customer_id :bigint
#  number      :integer
#  date        :date
#  net_price   :float
#  vat         :float
#  total_price :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class IncomingInvoice < ApplicationRecord
  belongs_to :customer
  has_many :documents, as: :documentable, class_name: 'DocumentedProduct', dependent: :destroy
  has_many :products, through: :documents, foreign_key: :product_id

  accepts_nested_attributes_for :documents, allow_destroy: true, reject_if: :all_blank

  def generate_number
    invoices_count = IncomingInvoice.count
    year = Date.today.strftime('%y')
    self.number = "#{year}#{(invoices_count + 1).to_s.rjust(3, '0')}".to_i
  end
end
