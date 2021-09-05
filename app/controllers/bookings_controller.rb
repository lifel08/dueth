class BookingsController < ApplicationController
  def create
    @booking = Booking.new
    @booking.instrument = Instrument.find(params[:instrument_id])
    @booking.user = current_user
    @booking.receiver = current_user
    @booking.provider = @booking.instrument.user
    @booking.disponibility_id = params[:instrument][:disponibility_id]
    @booking.status = 0
    if @booking.save
      redirect_to instrument_path(@booking.instrument), notice: "Pending approval of Instrument Owner #{@booking.instrument.user.first_name}"
    else
      redirect_to instrument_path(@booking.instrument), status: :unprocessable_entity, notice: @booking.errors.full_messages.join(" , ")
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    if current_user == @booking.instrument.provider
      redirect_to instrument_path, notice: "You declined #{@booking.receiver} request"
    else
      redirect_to instrument_bookings_path(@instrument), notice: "Your booking for #{@instrument.title} is CANCELLED"
    end
  end

  def accept
    @booking = Booking.find(params[:id])
    @booking.update(status: 1)
    redirect_to instrument_path, notice: "#{@booking.user.first_name}' s booking <strong>confirmed!</strong>"
  end

  def decline
    @booking = Booking.find(params[:id])
    @booking.update(status: 3)
    redirect_to instrument_path
  end
end
