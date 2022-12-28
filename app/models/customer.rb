# == Schema Information
#
# Table name: customers
#
#  id         :bigint           not null, primary key
#  name       :string
#  address    :string
#  phone      :string
#  edb        :string
#  emb        :string
#  due        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Customer < ApplicationRecord
  enum customer_type: %i[company person]

  has_many :invoices, dependent: :destroy
  has_many :incoming_invoices, dependent: :destroy

  def total
    invoices.sum(:total_price)
  end
end
