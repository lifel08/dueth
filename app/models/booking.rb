class Booking < ApplicationRecord
  belongs_to :instrument
  belongs_to :user, optional: true
  belongs_to :receiver, class_name: 'User', foreign_key: :receiver_id
  belongs_to :provider, class_name: 'User', foreign_key: :provider_id
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
