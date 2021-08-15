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
  belongs_to :booking
  validates :from, :to, presence: true

  def start_from
    from.strftime("%A, %H:%M")
  end

  def until_to
    to.strftime("%A, %H:%M")
  end
end
