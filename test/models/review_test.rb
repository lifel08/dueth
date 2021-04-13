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
#  booking_id    :bigint           not null
#  instrument_id :bigint           not null
#  user_id       :bigint
#
# Indexes
#
#  index_reviews_on_booking_id     (booking_id)
#  index_reviews_on_instrument_id  (instrument_id)
#  index_reviews_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (booking_id => bookings.id)
#  fk_rails_...  (instrument_id => instruments.id)
#
require "test_helper"

class ReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
