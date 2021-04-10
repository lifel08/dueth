class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confir
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :bookings
  has_many :instruments
  has_many :reviews, through: :bookings
  has_one_attached :photo

  def registered_since
    # timestamp
  end

end
