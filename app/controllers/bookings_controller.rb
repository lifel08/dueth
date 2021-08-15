class BookingsController < ApplicationController
  def create
    @booking = Booking.new
    @booking.instrument = Instrument.find(params[:instrument_id])
    @booking.user = current_user
    @booking.status = false
    if @booking.save
      redirect_to instrument_path(@booking.instrument), notice: "Pending approval of Instrument Owner #{@booking.instrument.provider_id.first_name}"
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to instrument_path(@booking.instrument), notice: "Your booking for #{@instrument.title} is CANCELLED"
  end

  def accept
    @booking = Booking.find(params[:id])
    @booking.update(status: true)
    redirect_to instrument_path, notice: "#{@booking.user.first_name}' s booking <strong>confirmed!</strong>"
  end

  def decline
    @booking = Booking.find(params[:id])
    @booking.update(status: false)
    redirect_to instrument_path
  end
end
