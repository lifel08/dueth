# == Schema Information
#
# Table name: availabilities
#
#  id             :bigint           not null, primary key
#  available      :boolean          default(FALSE)
#  day            :string
#  end_datetime   :datetime
#  from           :string
#  occurence      :integer          default(NULL)
#  start_datetime :datetime
#  status         :string
#  to             :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  instrument_id  :integer
#
class Availability < ApplicationRecord
  belongs_to :instrument, optional: true
  
  has_many :bookings
  has_many :instrument_availabilitiy
  has_many :instruments, through: :instrument_availabilitiy

  validates_presence_of :to, presence: true,  message: "The Start Time field is required"
  validates_presence_of :from, presence: true,  message: "The End Time field is required"

  enum occurence: {
    weekly: 0,
    monthly: 1,
    annually: 2
  }

  enum occurence: {
    available: 'available',
    booked: 'booked'
  }

  def schedule
    schedule = IceCube::Schedule.new(now = start_datetime)
    case occurence
    when 'weekly'
      schedule.add_recurrence_rule IceCube::Rule.weekly(4)
    when 'monthly'
      schedule.add_recurrence_rule IceCube::Rule.monthly(1)
    when 'annually'      
      schedule.add_recurrence_rule IceCube::Rule.yearly(1)
    end
    schedule
  end
end
