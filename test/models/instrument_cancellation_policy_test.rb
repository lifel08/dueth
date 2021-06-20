# == Schema Information
#
# Table name: instrument_cancellation_policies
#
#  id                     :bigint           not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  cancellation_policy_id :bigint           not null
#  instrument_id          :bigint           not null
#
# Indexes
#
#  cp_instrument  (cancellation_policy_id)
#  instrument_cp  (instrument_id)
#
# Foreign Keys
#
#  fk_rails_...  (cancellation_policy_id => cancellation_policies.id)
#  fk_rails_...  (instrument_id => instruments.id)
#
require "test_helper"

class InstrumentCancellationPolicyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
