class AvailabilitiesController < ApplicationController
  before_action :get_instrument
  before_action :set_availability, only: [:edit, :update]
  def index
    @instrument_availabilities = @instrument.availabilities.all
  end

  def edit

  end

  def update
    respond_to do |format|
      if @availability.update!(availability_params)
        format.html {redirect_to instrument_availabilities_path(@instrument), info: 'Availability was successfully updated.'}
      else
        format.html {render :edit}
      end
    end
  end

  private
  def get_instrument
    @instrument = Instrument.find(params[:instrument_id])
  end

  def set_availability
    @availability = Availability.find(params[:id])
  end

  def availability_params
    params.require(:availability).permit(:to, :from, :day, :available, :instrument_id)
  end
end