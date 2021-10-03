# == Schema Information
#
# Table name: bookings
#
#  id               :bigint           not null, primary key
#  from             :datetime
#  status           :integer
#  to               :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  disponibility_id :bigint           not null
#  instrument_id    :bigint
#  provider_id      :bigint
#  receiver_id      :bigint
#  user_id          :bigint
#
# Indexes
#
#  index_bookings_on_disponibility_id  (disponibility_id)
#  index_bookings_on_instrument_id     (instrument_id)
#  index_bookings_on_provider_id       (provider_id)
#  index_bookings_on_receiver_id       (receiver_id)
#  index_bookings_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (disponibility_id => disponibilities.id)
#
class Booking < ApplicationRecord
  belongs_to :instrument
  belongs_to :user, optional: true
  belongs_to :receiver, class_name: 'User', foreign_key: :receiver_id
  belongs_to :provider, class_name: 'User', foreign_key: :provider_id
  belongs_to :disponibility
  has_many :reviews, dependent: :destroy
  scope :upcoming, -> { joins(:disponibility).where('DATE(disponibilities.from) > DATE(?)', Time.zone.now) }
  scope :past, -> { joins(:disponibility).where('DATE(disponibilities.to) < DATE(?)', Time.zone.now) }
  scope :requested_by, -> (user_id){ where('bookings.receiver_id = ?', user_id )}

  def booking_status
    if self.status.zero?
      "pending"
    elsif self.status == 1
      "accepted"
    elsif self.status == 2
      "declined"
    else
      "cancelled"
    end
  end

  def accepted?
    status == 1
  end

  def booking_timeframe
    disponibility.from.strftime("%A, #{ disponibility.from.day.ordinalize } of %B #{ booking_hour_from} #{ booking_hour_to}")
  end
  def booking_day
    disponibility.from.strftime("%A, #{ disponibility.from.day.ordinalize } of %B %Y")
  end

  def booking_hour_from
    disponibility.from.strftime(" from %H:%M")
  end

  def booking_hour_to
    disponibility.to.strftime(" to %H:%M")
  end
end
