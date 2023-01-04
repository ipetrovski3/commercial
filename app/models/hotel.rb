class Hotel < ApplicationRecord
  belongs_to :customer
  has_many :tire_hotels, dependent: :destroy

  accepts_nested_attributes_for :tire_hotels, allow_destroy: true, reject_if: :all_blank

  scope :in_hotel, -> { where(date_out: nil) }
  scope :summer, -> { joins(:tire_hotels).where(tire_hotels: { season: 'summer' }) }
  scope :winter, -> { joins(:tire_hotels).where(tire_hotels: { season: 'winter' }) }
  scope :all_season, -> { joins(:tire_hotels).where(tire_hotels: { season: 'all_season' }) }
end
