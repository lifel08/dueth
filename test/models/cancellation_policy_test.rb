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
require "test_helper"

class CancellationPolicyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
