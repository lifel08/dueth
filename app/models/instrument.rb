# == Schema Information
#
# Table name: instruments
#
#  id                     :bigint           not null, primary key
#  description            :string
#  latitude               :decimal(, )
#  location               :string
#  longitude              :decimal(, )
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
class Instrument < ApplicationRecord
  include PgSearch::Model

  belongs_to :user
  has_many :bookings
  has_many :reviews, through: :bookings
  has_many :features, through: :instrument_features
  has_one :cancellation_policy
  validates :title, :subtitle, :location, :latitude, :longitude, :price, presence: true
  has_one_attached :photo

  pg_search_scope :search_title_and_location,
   against: [ :title, :location ]
end
