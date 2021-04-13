# == Schema Information
#
# Table name: instrument_features
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  feature_id    :bigint
#  instrument_id :bigint           not null
#
# Indexes
#
#  index_instrument_features_on_feature_id     (feature_id)
#  index_instrument_features_on_instrument_id  (instrument_id)
#
# Foreign Keys
#
#  fk_rails_...  (instrument_id => instruments.id)
#
class InstrumentFeature < ApplicationRecord
  belongs_to :feature
  belongs_to :instrument
end
