class BookingMailer < ApplicationMailer

  def decline_booking(booking)
    @booking = booking
    user = @booking.pluck(:user_id)
    @book = User.where(id: user).collect(&:email).join(",")
    mail(to: @book, subject: "Decline your request")
  end
end