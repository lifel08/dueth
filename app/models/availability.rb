# == Schema Information
#
# Table name: availabilities
#
#  id            :bigint           not null, primary key
#  available     :boolean          default(FALSE)
#  day           :string
#  from          :string
#  to            :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  instrument_id :integer
#
class Availability < ApplicationRecord
  belongs_to :instrument, optional: true
  has_many :bookings
  validates_presence_of :to, presence: true,  message: "The Start Time field is required"
  validates_presence_of :from, presence: true,  message: "The End Time field is required"
end
