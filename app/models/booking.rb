class Booking < ApplicationRecord
  belongs_to :instrument
  belongs_to :user
  has_many :reviews, dependent: :destroy

  def booking_status
    if self.status.nil?
        "pending"
      elsif self.status?
        "accepted"
      else
        "declined"
      end
  end
end
