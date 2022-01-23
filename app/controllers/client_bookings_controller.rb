class ClientBookingsController < ApplicationController

  def index
    add_breadcrumb "Your Bookings", :user_client_bookings_path
    @bookings = current_user.bookings
  end
end
