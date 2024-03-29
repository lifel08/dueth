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
class Instrument < ApplicationRecord
  include PgSearch::Model

  belongs_to :user
  belongs_to :cancellation_policy

  has_many :reviews
  # has_many :bookings, inverse_of: :instrument
  has_many :bookings, dependent: :destroy
  has_many :disponibilities, inverse_of: :instrument
  has_many :reviews, dependent: :destroy
  has_many :instrument_disponbilities
  has_many :instrument_features, dependent: :destroy
  has_many :features, through: :instrument_features

  has_many :instrument_availabilities ,dependent: :destroy
  has_many :availabilities, through: :instrument_availabilities , dependent: :destroy

  has_many :favourite_instruments # just the 'relationships'
  has_many :favorited_by, through: :favourite_instruments, source: :instrument
  
  has_many_attached :photo 
  
  validates :title, :subtitle, :street_name, :house_number, :postal_code, :city, presence: true
  # after_create :set_availability
  
  pg_search_scope :search_title_and_location,
    against: [ :title, :city ]

  geocoded_by :address
  accepts_nested_attributes_for :availabilities, reject_if: :all_blank, allow_destroy: true

  def as_json(options = nil)
    super.merge(center: center)
  end

  def address
    #  ||= memoization means, if = nil than assign not
    @address ||= [street_name, district, postal_code, city, country]
    .compact
    .join(", ")
  end

  def display_address
    @display_address ||= [district, postal_code, city, country]
    .compact
    .join(", ")
  end

  # marker-position
  def center
    @center ||= [longitude, latitude]
  end
  after_validation :geocode

  scope :paused, -> { where(pause: true) }
  scope :active, -> { where(pause: false) }

  def activate!
    update(pause: false)
  end

  def pause!
    update(pause: true)
  end

  def needs_approval
    # Check all the bookings are confirmed retun FALSE otherwise return N of bookings that needs approval
    to_approval = 0
    bookings.each do |booking|
      to_approval += booking.status ? 0 : 1
    end
    to_approval.zero? ? false : to_approval
  end

  def been_booked_by?(user)
    condition = false
    user.bookings.each do |booking|
      condition = true if booking.user == user && booking.instrument.id == id
    end
    condition
  end

  def average_rating
    average = 0
    reviews.each do |review|
      average += review.rating
    end
    return average.zero? ? average : (average / reviews.size).round
  end

  private
  
  # def set_availability
  #   week_days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
  #   week_days.each do |day|
  #     availabilities.create(day: day, to: '00:00', from:'23:59' , available: false )
  #   end
  # end
end
