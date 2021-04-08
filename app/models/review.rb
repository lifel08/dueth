class Review < ApplicationRecord
  belongs_to :booking
  belongs_to :user, through: :booking
  belongs_to :instrument, through: :booking
  validates :content, :booking, presence: true
  validates :rating, inclusion: { in: 0..5 }, numericality: { only_integer: true }
end


