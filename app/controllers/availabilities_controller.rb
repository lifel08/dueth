class AvailabilitiesController < ApplicationController
  before_action :get_instrument
  before_action :set_availability, only: [:edit, :update]

  def index
    @instrument_availabilities = @instrument&.instrument_availabilities
  end

  def new
    @availability = Availability.new
  end
  def create
    if params.has_key?("data")
      data = params[:data].permit!
      if params[:user_id] == @instrument.user_id
        @instrument.availabilities.create!(start_datetime:  data[:start]["_date"], end_datetime:  data[:end]["_date"])
        redirect_to instrument_availabilities_path
      else
        render 'Sorry you are not instrumnet owner!'
      end
    else
      if @instrument.availabilities.create!(availability_params)
        redirect_to instrument_availabilities_path
      else
        render :new
      end
    end
  end

  def edit

  end

  def update
    @instrument_availability = @availability.instrument_availabilities.find_by(instrument_id: params[:instrument_id])
    return 'instrument availablity is not found' if @instrument_availability.blank?

    if @instrument_availability.pending? || @instrument_availability.booked?
       @instrument_availability.update(status: params[:status])
    else
       @instrument_availability.update(status: params[:status], user_id: current_user.id)
    end

  end

  def change_status
    @post = Post.find(params[:id])
    if params[:status].present? && Post::STATUSES.include?(params[:status].to_sym)
      @post.update(status: params[:status])
    end
    redirect_to @post, notice: "Status updated to #{@post.status}"
  end
  def destroy
    @instrument_availability = Availability.find(params[:id])
    @instrument_availability.destroy
  end

  private

  def get_instrument
    @instrument = Instrument.find(params[:instrument_id])
  end

  def set_availability
    @availability = Availability.find(params[:id])
  end

  def availability_params
    params.require(:availability).permit(:start_datetime, :end_datetime, availability_date_time_attributes: [:start_datetime, :end_datetime])
  end
end
