# == Schema Information
#
# Table name: invoices
#
#  id            :bigint           not null, primary key
#  customer_id   :bigint
#  number        :integer
#  date          :date
#  net_price     :float
#  vat           :float
#  total_price   :float
#  received_by   :string
#  licence_plate :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  due_days      :integer          default(0)
#
class Invoice < ApplicationRecord
  VAT_CALCULATOR = 1.18

  belongs_to :customer
  has_many :documents, as: :documentable, class_name: 'DocumentedProduct', dependent: :destroy
  has_many :products, through: :documents, foreign_key: :product_id

  accepts_nested_attributes_for :documents, allow_destroy: true, reject_if: :all_blank

  validates :number, presence: true, uniqueness: true
  validates :date, presence: true
  # validates :customer, presence: true

  validates_presence_of :documents, in: :documents_attributes
  

  def generate_invoice_number
    invoices_count = Invoice.count
    year = Date.today.strftime('%y')
    self.number = "#{year}#{(invoices_count + 1).to_s.rjust(3, '0')}".to_i
  end

  def due_date
    date + self.customer.due.to_i.days
  end

  def formated_date
    date.strftime('%d.%m.%Y')
  end
end
