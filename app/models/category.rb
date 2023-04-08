# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  cat_type   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ApplicationRecord
  has_many :brands
  has_many :patterns, through: :brands

  enum cat_type: %i[goods service]
end
