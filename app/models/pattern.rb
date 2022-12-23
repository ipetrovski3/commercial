# == Schema Information
#
# Table name: patterns
#
#  id         :bigint           not null, primary key
#  name       :string
#  season     :integer
#  brand_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Pattern < ApplicationRecord
  belongs_to :brand
  has_many :products

  enum season: { summer: 0, winter: 1, all_season: 2 }

  validates :name, presence: true, uniqueness: { scope: :brand_id }
end
