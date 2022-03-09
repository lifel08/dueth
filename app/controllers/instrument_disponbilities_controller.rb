class InstrumentDisponbilitiesController < ApplicationController
  before_action :find_instrument

  def new
    @disponbility = @instrument.instrument_disponbilities.new
  end

  def create
    start_date = params[:instrument_disponbility][:start_date]
    end_date = params[:instrument_disponbility][:end_date]
    disponbility = @instrument.instrument_disponbilities.where("start_date <= ? AND end_date >= ?", start_date, end_date) || @instrument.instrument_disponbilities.where(:created_at => start_date..end_date)
    if disponbility.present?
      redirect_to instrument_path(@instrument), notice: "Instrument disponbility already exist "
    else
      @disponbility = @instrument.instrument_disponbilities.new(instrument_params)
      @disponbility.user_id = current_user.id
      if @disponbility.save
        redirect_to instrument_path(@instrument)
      else
        render :new
      end
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

end
