# == Schema Information
#
# Table name: instrument_disponbilities
#
#  id            :bigint           not null, primary key
#  availability  :boolean
#  end_date      :datetime
#  start_date    :datetime
#  status        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  instrument_id :bigint
#  user_id       :bigint
#
# Indexes
#
#  index_instrument_disponbilities_on_instrument_id  (instrument_id)
#  index_instrument_disponbilities_on_user_id        (user_id)
#
class InstrumentDisponbility < ApplicationRecord
  belongs_to :instrument, inverse_of: :instrument_disponbilities
  belongs_to :user
  has_many :bookings
  # has_many :own_bookings, class_name: "Booking", foreign_key: :receiver_id
  validates :start_date, :end_date, presence: true
  before_destroy :remove_booking_reference

  def start_from
    start_date.strftime("%B, %d. %A, %H:%M")
  end

  def until_to
    end_date.strftime("%B, %d. %A, %H:%M")
  end

  def remove_booking_reference
    bookings.upcoming.find_each do |booking|
      booking.update!(instrument_disponbility_id: nil, status: 3)
    end
  end

  enum status: { hourly: "hourly", daily: "daily", weekly: "weekly", monthly: "monthly" }

end

