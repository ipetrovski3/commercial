class Hotel < ApplicationRecord
  belongs_to :customer

  has_many :tire_hotels, dependent: :destroy

  accepts_nested_attributes_for :tire_hotels, allow_destroy: true, reject_if: :all_blank
end
