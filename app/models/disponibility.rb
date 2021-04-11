class Disponibility < ApplicationRecord
  has_one :instrument
  validates :from, :to, presence: true
end
