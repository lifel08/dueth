# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  birthday               :datetime
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
  has_many :instruments
  has_many :reviews, through: :bookings
  validates :first_name, :last_name, :birthday, :password, :language,
  :photo, presence: true
  has_one_attached :photo

  def registered_since
    # timestamp
  end

  def full_name
    [first_name, last_name].compact.join(' ')
  end

end
