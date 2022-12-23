# == Schema Information
#
# Table name: tire_dimensions
#
#  id         :bigint           not null, primary key
#  dimension  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TireDimension < ApplicationRecord
end
