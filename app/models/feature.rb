class Feature < ApplicationRecord
  validates :name, presence: true
  has_one_attached :photo
end
