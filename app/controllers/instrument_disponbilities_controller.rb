class InstrumentDisponbilitiesController < ApplicationController
  before_action :find_instrument

  def new
    @disponbility = @instrument.instrument_disponbilities.new
  end

  def create
    day = params[:instrument_disponbility][:start_date].to_datetime.strftime('%A')
    start_time = params[:instrument_disponbility][:start_date].to_datetime.strftime('%H:%M')
    end_time = params[:instrument_disponbility][:end_date].to_datetime.strftime('%H:%M')
    # check Availability
    arr = []
    @availabilities = Availability.where(instrument_id: @instrument.id, available: true)
    if @availabilities.present?
      @availabilities.each do |availability|
        ((availability.day == day) && (availability.to == start_time) && (availability.from == end_time)) ? (redirect_to instrument_path(@instrument), notice: "Availability exist ") : (arr << availability)
      end
      create_disponbility(params) if arr.count == @availabilities.count
    else
      create_disponbility(params)
    end
  end

  def destroy
    @disponbility = @instrument.instrument_disponbilities.find(params[:id])
    redirect_to instrument_path(@instrument), notice: "Instrument disponbility has been deleted" if @disponbility.delete
  end

  private
  def find_instrument
    @instrument = Instrument.find(params[:instrument_id])
  end

  def instrument_params
    params.require(:instrument_disponbility).permit(:start_date, :end_date, :status, :availability)
  end

  def create_disponbility(params)
    start_date = params[:instrument_disponbility][:start_date]
    end_date = params[:instrument_disponbility][:end_date]
    disponbility = @instrument.instrument_disponbilities.where("start_date <= ? AND end_date >= ?", start_date, end_date) || @instrument.instrument_disponbilities.where(:created_at => start_date..end_date)
    if disponbility.present?
      redirect_to instrument_path(@instrument), notice: "Instrument disponbility already exist"
      # create Instrument Disponbility for monthly
    elsif (params[:instrument_disponbility][:status] == "monthly")
      monthly_disponbility(params)
    else
      @disponbility = @instrument.instrument_disponbilities.new(instrument_params)
      @disponbility.user_id = current_user.id
      (@disponbility.save) ? (redirect_to instrument_path(@instrument)) : (render :new)
    end
  end

  def monthly_disponbility(params)
    params[:instrument_disponbility][:start_date] = (params[:instrument_disponbility][:start_date].to_datetime)
    params[:instrument_disponbility][:end_date] = (params[:instrument_disponbility][:end_date].to_datetime)
    month = params[:instrument_disponbility][:start_date].month
    loop do
      if month != params[:instrument_disponbility][:start_date].month
        (@disponbility.save) ? (redirect_to instrument_path(@instrument)) : (render :new)
        break
      else
        @disponbility = @instrument.instrument_disponbilities.new(instrument_params)
        @disponbility.user_id = current_user.id
        @disponbility.save
        params[:instrument_disponbility][:start_date] = params[:instrument_disponbility][:start_date] + 7.days
        params[:instrument_disponbility][:end_date] = params[:instrument_disponbility][:end_date] + 7.days
      end
    end
  end
end
