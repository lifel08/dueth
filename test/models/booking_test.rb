# == Schema Information
#
# Table name: bookings
#
#  id                         :bigint           not null, primary key
#  day                        :string
#  from                       :datetime
#  status                     :integer
#  to                         :datetime
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  availability_id            :integer
#  disponibility_id           :bigint
#  instrument_disponbility_id :bigint
#  instrument_id              :bigint
#  provider_id                :bigint
#  receiver_id                :bigint
#  user_id                    :bigint
#
# Indexes
#
#  index_bookings_on_disponibility_id            (disponibility_id)
#  index_bookings_on_instrument_disponbility_id  (instrument_disponbility_id)
#  index_bookings_on_instrument_id               (instrument_id)
#  index_bookings_on_provider_id                 (provider_id)
#  index_bookings_on_receiver_id                 (receiver_id)
#  index_bookings_on_user_id                     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (disponibility_id => disponibilities.id)
#  fk_rails_...  (instrument_disponbility_id => instrument_disponbilities.id)
#
require "test_helper"

class BookingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
