# == Schema Information
#
# Table name: reviews
#
#  id            :bigint           not null, primary key
#  content       :string
#  instrument    :bigint
#  rating        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  instrument_id :bigint           not null
#  user_id       :bigint
#
# Indexes
#
#  index_reviews_on_instrument_id  (instrument_id)
#  index_reviews_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (instrument_id => instruments.id)
#
class Review < ApplicationRecord
  belongs_to :user
  belongs_to :instrument
  validates :user_id, uniqueness: true
  validates :content, :instrument, presence: true

  def average_rating
    average = 0
    review.rating.each do |review|
      average += review.rating
    end
    return average.zero? ? average : (average / reviews.size).round
  end

  def rating
    if content == 'Excellent - Amazing Instrument & awesome Owner'
      rating = 3
    elsif content == 'Good - Nice to play Instrument and respectful Owner '
      rating = 2
    else
      rating = 1
    end
  end

end
