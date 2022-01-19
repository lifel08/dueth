# == Schema Information
#
# Table name: favourite_instruments
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  instrument_id :bigint
#  user_id       :bigint
#
# Indexes
#
#  index_favourite_instruments_on_instrument_id  (instrument_id)
#  index_favourite_instruments_on_user_id        (user_id)
#
class FavouriteInstrument < ApplicationRecord
  belongs_to :instrument
  belongs_to :user
end
