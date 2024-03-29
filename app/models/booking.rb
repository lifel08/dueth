# == Schema Information
#
# Table name: bookings
#
#  id                         :bigint           not null, primary key
#  day                        :string
#  from                       :datetime
#  status                     :integer
#  to                         :datetime
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  availability_id            :integer
#  disponibility_id           :bigint
#  instrument_disponbility_id :bigint
#  instrument_id              :bigint
#  provider_id                :bigint
#  receiver_id                :bigint
#  user_id                    :bigint
#
# Indexes
#
#  index_bookings_on_disponibility_id            (disponibility_id)
#  index_bookings_on_instrument_disponbility_id  (instrument_disponbility_id)
#  index_bookings_on_instrument_id               (instrument_id)
#  index_bookings_on_provider_id                 (provider_id)
#  index_bookings_on_receiver_id                 (receiver_id)
#  index_bookings_on_user_id                     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (disponibility_id => disponibilities.id)
#  fk_rails_...  (instrument_disponbility_id => instrument_disponbilities.id)
#
class Booking < ApplicationRecord
  belongs_to :instrument
  belongs_to :user, optional: true
  belongs_to :receiver, class_name: 'User', foreign_key: :receiver_id
  belongs_to :provider, class_name: 'User', foreign_key: :provider_id
  belongs_to :instrument_disponbility, optional: true
  belongs_to :availability, optional: true
  belongs_to :instrument_availability, optional: true
  scope :upcoming, -> { joins(:instrument_availability).where('instrument_disponbilities.start_date > ?', Time.zone.now) }
  # scope :past, -> { joins(:instrument_disponbility).where('instrument_disponbilities.end_date < ?', Time.zone.now) }
  scope :requested_by, -> (user_id){ where('bookings.receiver_id = ?', user_id )}
  scope :pending, -> { where(status: 0) }
  scope :upcoming_availability, -> { joins(:availability).where('availabilities.day > ?', Time.zone.now) }
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
    availability.start_datetime.strftime("%A, #{ availability.start_datetime.day.ordinalize } of %B #{ booking_hour_from} #{ booking_hour_to}")
  end
  def booking_day
    availability.start_datetime.strftime("%A, #{ availability.start_datetime.day.ordinalize } of %B %Y")
  end

  def booking_hour_from
    availability.start_datetime.strftime(" start_date %H:%M")
  end

  def booking_hour_to
    availability.end_datetime.strftime(" end_date %H:%M")
  end
  def booking_start_from
    availability.start_datetime.strftime("%B, %d. %A, %H:%M")
  end
  def booking_end_to
    availability.end_datetime.strftime("%B, %d. %A, %H:%M")
  end
end
