# == Schema Information
#
# Table name: instruments
#
#  id                     :bigint           not null, primary key
#  city                   :string
#  country                :string
#  description            :string
#  district               :string
#  flat_number            :string
#  house_number           :string
#  latitude               :decimal(, )
#  location               :string
#  longitude              :decimal(, )
#  pause                  :boolean          default(FALSE)
#  postal_code            :string
#  price                  :integer
#  street_name            :string
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
#  index_instruments_on_city                    (city)
#  index_instruments_on_country                 (country)
#  index_instruments_on_district                (district)
#  index_instruments_on_flat_number             (flat_number)
#  index_instruments_on_house_number            (house_number)
#  index_instruments_on_postal_code             (postal_code)
#  index_instruments_on_street_name             (street_name)
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
