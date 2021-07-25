# == Schema Information
#
# Table name: disponibilities
#
#  id            :bigint           not null, primary key
#  from          :datetime
#  to            :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  instrument_id :bigint
#
# Indexes
#
#  index_disponibilities_on_instrument_id  (instrument_id)
#
class Disponibility < ApplicationRecord
  belongs_to :instrument
  validates :from, :to, presence: true
end
