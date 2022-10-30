class ClientBookingsController < ApplicationController

  def index
    add_breadcrumb "My Profile", :profile_path
    add_breadcrumb "My Bookings", :user_client_bookings_path
    @instrument_availabilities = InstrumentAvailability.joins(instrument: [:user]).where(users: {id: current_user})
    @instrument_booking = Booking.where(receiver_id: current_user.id)
  end
end
