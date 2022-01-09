# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  birthday               :datetime
#  description            :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  language               :string           default("en")
#  last_name              :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_language              (language)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confir
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  has_many :bookings
  # when someone books my instruments
  has_many :received_bookings, class_name:"Booking", foreign_key: :provider_id,
    inverse_of: :provider
  # when I book someone's instruments
  has_many :own_bookings, class_name:"Booking", foreign_key: :receiver_id,
    inverse_of: :receiver
  has_many :instruments
  has_many :reviews, through: :instruments
  validates :first_name, :last_name, :birthday, :language,
    :photo, presence: true
  has_one_attached :photo
  has_many :favourite_instruments # just the 'relationships'
  has_many :favorites, through: :favourite_instruments, source: :instrument

  def member_since
    created_at.strftime('%B, %Y')
  end

  def full_name
    [first_name, last_name].compact.join(' ')
  end

end
