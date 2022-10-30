# == Schema Information
#
# Table name: availability_date_times
#
#  id                :bigint           not null, primary key
#  end_datetime      :datetime
#  start_datetime    :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  availabilities_id :bigint
#
# Indexes
#
#  index_availability_date_times_on_availabilities_id  (availabilities_id)
#
require "test_helper"

class AvailabilityDateTimeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
