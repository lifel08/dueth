# == Schema Information
#
# Table name: instrument_availabilities
#
#  id              :bigint           not null, primary key
#  status          :string           default("available")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  availability_id :bigint           not null
#  instrument_id   :bigint           not null
#  user_id         :bigint
#
# Indexes
#
#  index_instrument_availabilities_on_availability_id  (availability_id)
#  index_instrument_availabilities_on_instrument_id    (instrument_id)
#
# Foreign Keys
#
#  fk_rails_...  (availability_id => availabilities.id)
#  fk_rails_...  (instrument_id => instruments.id)
#
class InstrumentAvailability < ApplicationRecord

	belongs_to :instrument
	belongs_to :availability
	after_destroy :remove_availability_reference

  enum status: {
	  available: 'Available',
	  pending: 'Pending',
	  booked: 'Booked',
	  canceled: 'Canceled'
  }
	def remove_availability_reference
		availability.delete
	end

end
