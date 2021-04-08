class CancellationPolicy < ApplicationRecord
  # belongs_to :instrument
  validates :name, :hours, presence: true
end
