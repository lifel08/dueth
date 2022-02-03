class ClientBookingsController < ApplicationController

  def index
    add_breadcrumb "My Profile", :profile_path
    add_breadcrumb "My Bookings", :user_client_bookings_path
    @bookings = current_user.bookings
  end
end
