# == Schema Information
#
# Table name: brands
#
#  id          :bigint           not null, primary key
#  name        :string
#  category_id :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Brand < ApplicationRecord
  belongs_to :category
  has_many :patterns
  has_many :products, through: :patterns

  validates :name, presence: true, uniqueness: true
end
