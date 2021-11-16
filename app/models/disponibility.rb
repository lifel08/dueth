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
  belongs_to :instrument, inverse_of: :disponibilities
  has_many :bookings
  validates :from, :to, presence: true
  before_destroy :remove_booking_reference

  def start_from
    from.strftime("%B, %A, %H:%M")
  end

  def until_to
    to.strftime("%B, %A, %H:%M")
  end

  def remove_booking_reference
    bookings.upcoming.find_each do |booking|
      booking.update!(disponibility_id: nil, status: 3)
    end
  end
end
