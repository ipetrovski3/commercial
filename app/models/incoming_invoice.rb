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
  belongs_to :warehouse
  has_many :documents, as: :documentable, class_name: 'DocumentedProduct', dependent: :destroy
  has_many :products, through: :documents, foreign_key: :product_id

  accepts_nested_attributes_for :documents, allow_destroy: true, reject_if: :all_blank

  validates :number, presence: true, uniqueness: true
  validates :date, presence: true

  def generate_number
    warehouse = Warehouse.first
    invoices_count = warehouse.incoming_invoices.count
    year = Date.today.strftime('%y')
    self.number = "#{year}#{(invoices_count + 1).to_s.rjust(3, '0')}".to_i
  end

  def formated_date
    date.strftime('%d.%m.%Y')
  end
end
