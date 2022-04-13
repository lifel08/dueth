class BookingMailer < ApplicationMailer

  def delete_booking(booking)
    @booking = booking
    user = @booking.pluck(:user_id)
    @book = User.where(id: user).collect(&:email).join(",")
    mail(to: @book, subject: "Decline your request")
  end

  def decline_booking(booking)
    @booking = booking
    user = @booking.user_id
    @book = User.where(id: user).collect(&:email).join(",")
    mail(to: @book, subject: "Decline your request")
  end

  def mail_to_owner(booking)
    @booking = booking.instrument
    user = @booking.user_id
    @book = User.where(id: user).collect(&:email).join(",")
    mail(to: @book, subject: "Decline your request")
  end
end
