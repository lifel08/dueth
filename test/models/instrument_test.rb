# == Schema Information
#
# Table name: instruments
#
#  id                     :bigint           not null, primary key
#  description            :string
#  latitude               :decimal(, )
#  location               :string
#  longitude              :decimal(, )
#  pause                  :boolean          default(FALSE)
#  price                  :integer
#  subtitle               :string
#  title                  :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  cancellation_policy_id :bigint
#  user_id                :bigint           not null
#
# Indexes
#
#  index_instruments_on_cancellation_policy_id  (cancellation_policy_id)
#  index_instruments_on_user_id                 (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class InstrumentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
