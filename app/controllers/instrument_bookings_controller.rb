class InstrumentBookingsController < ApplicationController

  def index
    add_breadcrumb "My Profile", :profile_path
    add_breadcrumb "Instrument Booking", :instrument_instrument_bookings_path
    @instrument = Instrument.find(params[:instrument_id])
    @bookings = @instrument.bookings
  end

  def create
    @booking = Booking.new
    @booking.instrument = Instrument.find(params[:instrument_id])
    @booking.instrument.instrument_availabilities.where(id: params[:availability_id]).update(status: "pending" )
    @booking.user = current_user
    @booking.receiver = current_user
    @booking.provider = @booking.instrument.user
    # @availability = Availability.find_by(instrument_id: params[:instrument_id], day: params[:day], to: params[:to], from: params[:from], available: params[:available])
    @availability= Availability.find(params[:availability_id])
    @booking.from = @availability.to
    @booking.to = @availability.from
    @booking.availability_id = @availability.id
    @booking.day = @availability.day
    @booking.status = 0
    if @booking.save
      # render instrument_path(@booking.instrument), notice: "Pending approval of Instrument Owner #{@booking.instrument.user.first_name}"
      redirect_to instrument_path(@booking.instrument), notice: "Pending approval of Instrument Owner #{@booking.instrument.user.first_name}"
    else
      redirect_to instrument_path(@booking.instrument), status: :unprocessable_entity, notice: @booking.errors.full_messages.join(" , ")
    end
  end


  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    if current_user == @booking.provider
      redirect_to instrument_instrument_bookings_path, notice: "You declined #{@booking.receiver} request"
    else
      redirect_to instrument_instrument_bookings_path, notice: "Your booking for #{@booking.instrument.title} is CANCELLED"
    end
  end

  def cancel
    @booking = Booking.find_by(availability_id: params[:id])
    @booking.destroy
    @booking.instrument.instrument_availabilities.find(@booking.availability_id).update(status: "available" )
    # render :index
    # redirect_to :profile_path
  end

  def accept
    @booking = Booking.find(params[:id])
    @booking.update(status: 1)
    @booking.instrument.instrument_availabilities.find(@booking.availability_id).update(status: "booked" )
    redirect_to instrument_instrument_bookings_path(@booking.instrument), notice: "#{@booking.user.first_name} \'s booking confirmed!"
  end

  def decline
    @booking = Booking.find(params[:id])
    @booking.update(status: 2)
    @booking.instrument.instrument_availabilities.find(@booking.availability_id).update(status: "available" )
    redirect_to instrument_path(@booking.instrument)
  end

end
