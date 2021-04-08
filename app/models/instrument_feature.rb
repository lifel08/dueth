class InstrumentFeature < ApplicationRecord
  belongs_to :feature
  belongs_to :instrument
end
