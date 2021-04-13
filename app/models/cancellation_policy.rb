# == Schema Information
#
# Table name: cancellation_policies
#
#  id         :bigint           not null, primary key
#  hours      :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CancellationPolicy < ApplicationRecord
  # belongs_to :instrument
  validates :name, :hours, presence: true
end
