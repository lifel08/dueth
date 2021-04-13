# == Schema Information
#
# Table name: bookings
#
#  id            :bigint           not null, primary key
#  from          :datetime
#  status        :integer
#  to            :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  instrument_id :bigint
#  provider_id   :bigint
#  receiver_id   :bigint
#  user_id       :bigint
#
# Indexes
#
#  index_bookings_on_instrument_id  (instrument_id)
#  index_bookings_on_provider_id    (provider_id)
#  index_bookings_on_receiver_id    (receiver_id)
#  index_bookings_on_user_id        (user_id)
#
require "test_helper"

class BookingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
