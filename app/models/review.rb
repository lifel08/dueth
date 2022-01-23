# == Schema Information
#
# Table name: reviews
#
#  id            :bigint           not null, primary key
#  content       :string
#  rating        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  instrument_id :bigint
#  user_id       :bigint
#
# Indexes
#
#  index_reviews_on_instrument_id  (instrument_id)
#  index_reviews_on_user_id        (user_id)
#
class Review < ApplicationRecord
  belongs_to :user
  belongs_to :instrument
  validates :user_id, uniqueness: true
  validates :content, :instrument, presence: true
  # enum rating: ["Excellent - Amazing Instrument & awesome Owner", "Good - Nice to play Instrument and respectful Owner","Bad - Instrument below expectations and unfriendly Owner"]
  after_save :update_rating


  def update_rating
    if content == 'Excellent - Amazing Instrument & awesome Owner'
      rating = 3
    elsif content == 'Good - Nice to play Instrument and respectful Owner'
      rating = 2
    else content == 'Bad - Below expectations Instrument and unfriendly Owner'
      rating = 1
    end
    update_column(:rating, rating)
  end


end
