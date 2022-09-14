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
require "test_helper"

class ReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
