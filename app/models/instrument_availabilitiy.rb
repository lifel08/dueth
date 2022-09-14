class InstrumentAvailabilitiy < ApplicationRecord
	belongs_to :instrument
	belongs_to :availability
  enum status: {
	  booked: 'booked',
	  available: 'available'
  }
end