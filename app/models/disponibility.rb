class Disponibility < ApplicationRecord
  # not sure? hase_one instrument or belongs to instrument?
  has_one :instrument
  validates :from, :to, presence: true
end
