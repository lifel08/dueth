class ClientBookingsController < ApplicationController

  def index
    add_breadcrumb "My Profile", :profile_path
    add_breadcrumb "My Bookings", :user_client_bookings_path
    # byebug
    @instrument_availabilities = InstrumentAvailability.joins(instrument: [:user]).where(users: {id: current_user})
    @instrument_booking = InstrumentAvailability.where(user_id: current_user.id)
  end
end
