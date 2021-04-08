class Feature < ApplicationRecord
  has_many :instrument_features
  validates :name, presence: true
  has_one_attached :photo
end
