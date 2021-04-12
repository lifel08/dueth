class Review < ApplicationRecord
  belongs_to :booking
  belongs_to :user
  belongs_to :instrument
  validates :user_id, uniqueness: true
  validates :content, :booking, presence: true
  validates :rating, inclusion: { in: 1..5 }, numericality: { only_integer: true }
end
