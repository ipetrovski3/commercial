class TireHotel < ApplicationRecord
  belongs_to :hotel

  enum season: %i[summer winter all_season]
end
