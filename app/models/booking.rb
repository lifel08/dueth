# == Schema Information
#
# Table name: bookings
#
#  id            :bigint           not null, primary key
#  from          :datetime
#  status        :integer
#  to            :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  instrument_id :bigint
#  provider_id   :bigint
#  receiver_id   :bigint
#  user_id       :bigint
#
# Indexes
#
#  index_bookings_on_instrument_id  (instrument_id)
#  index_bookings_on_provider_id    (provider_id)
#  index_bookings_on_receiver_id    (receiver_id)
#  index_bookings_on_user_id        (user_id)
#
class Booking < ApplicationRecord
  belongs_to :instrument
  belongs_to :user, optional: true
  belongs_to :receiver, class_name: 'User', foreign_key: :receiver_id
  belongs_to :provider, class_name: 'User', foreign_key: :provider_id
  has_many :reviews, dependent: :destroy
  has_many :disponibilities, dependent: :destroy

  scope :upcoming, -> { where('DATE(bookings.from) > DATE(?)', Time.zone.now) }
  scope :past, -> { where('DATE(bookings.to) < DATE(?)', Time.zone.now) }

  def booking_status
    if self.status.nil?
      "pending"
    elsif self.status?
      "accepted"
    else
      "declined"
    end
  end

  def booking_timeframe
    from.strftime("%A, #{ from.day.ordinalize } of %B #{ booking_hour_from} #{ booking_hour_to}")
  end
  def booking_day
    from.strftime("%A, #{ from.day.ordinalize } of %B %Y")
  end

  def booking_hour_from
    from.strftime(" from %H:%M")
  end

  def booking_hour_to
    to.strftime(" to %H:%M")
  end
end
